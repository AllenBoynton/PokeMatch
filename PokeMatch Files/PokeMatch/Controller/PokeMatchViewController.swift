//
//  PokeMatchViewController.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import GoogleMobileAds

// Global Identifier
let cellID = "PokeCell"

class PokeMatchViewController: UIViewController {
    
    //    private var card: Card!
    private var gameController = PokeMemoryGame()
    //    private var notifications = Notifications()
    //    private var music = Music()
    private var optionsVC = OptionsViewController()
    
    // Collection view to hold all images
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Outlet for game display
    @IBOutlet weak var timerDisplay: UILabel!
    
    // Outlets for views
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    // Constraint outlets for animation
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
    // MARK - Local variables
    
    // AdMob banner ad
    private var adBannerView: GADBannerView!
    
    // Time passed to FinalScoreVC
    private var gameTimePassed = UILabel()
    
    // Deducts images until we reach 0 and the user wins
    private var gameOver = Bool()
    
    // NSTimers for game time and delays in revealed images
    private var timer: Timer?
    private var timer1 = Timer(), timer2 = Timer(), timer3 = Timer()
    
    // Time values instantiated
    private var startTime: Double = 0
    private var time: Double = 0
    private var seconds = 0.99
    private var elapsed: Double = 0
    private var display: String = ""
    private var isTimerRunning = false
    private var resumeTapped = false
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        resetGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAdRequest()
        GADMobileAds.sharedInstance().applicationVolume = 0.5
        gameController.delegate = self
        restartButton.isHidden = true
    }
    
    // Sets up for new game
    private func setupNewGame() {
        let cardsData: [UIImage] = PokeMemoryGame.topCardImages
        gameController.newGame(cardsData)
    }
    
    // Created to reset game. Resets points, time and start button.
    private func resetGame() {
        gameController.stopGame()
        if timer?.isValid == true {
            timer?.invalidate()
        }
        
        bottomView.isHidden = true
        restartButton.isHidden = true
        collectionView.isHidden = true
        collectionView.isUserInteractionEnabled = true
        collectionView.reloadData()
        
        cancelButton.isHidden = false
        cancelButton.isEnabled = true
        
        playButton.isHidden = false
        playButton.isEnabled = true
    }
}

// MARK: - MemoryGameDelegate

extension PokeMatchViewController: MemoryGameDelegate {
    func memoryGameDidStart(_ game: PokeMemoryGame) {
        collectionView.reloadData()
        collectionView.isUserInteractionEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(startGameTimer), userInfo: nil, repeats: true)
    }
    
    // Function for cards that are being shown
    func memoryGame(_ game: PokeMemoryGame, showCards cards: [Card]) {
        for card in cards {
            guard let index = gameController.indexForCard(card) else { continue }
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! PokeViewCell
            cell.showCard(true, animated: true)
        }
    }
    
    // Function for cards that are being hidden
    func memoryGame(_ game: PokeMemoryGame, hideCards cards: [Card]) {
        for card in cards {
            guard let index = gameController.indexForCard(card) else { continue }
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! PokeViewCell
            cell.showCard(false, animated: true)
        }
    }
    
    // End of game methods
    func memoryGameDidEnd(_ game: PokeMemoryGame, elapsedTime: TimeInterval) {
        timer?.invalidate()
        
        let when = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "HighScoreViewController") as! HighScoreViewController
            myVC.timePassed = self.display
            self.present(myVC, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PokeMatchViewController: UICollectionViewDataSource {
    // Determines which device the user has - determines # of cards
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Device.IS_IPHONE {
            print("Device is iPhone. Number of cards: \(gameController.numberOfCards)")
            return gameController.numberOfCards > 0 ? gameController.numberOfCards: 20
        } else {
            print("Device is not an iPhone. Number of cards: \(gameController.numberOfCards)")
            return gameController.numberOfCards > 0 ? gameController.numberOfCards: 30
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PokeViewCell
        cell.showCard(false, animated: false)
        
        guard let card = gameController.cardAtIndex(indexPath.item) else { return cell }
        cell.card = card
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension PokeMatchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PokeViewCell
        
        if cell.shown { return }
        gameController.didSelectCard(cell.card)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PokeMatchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemWidth: CGFloat!
        var itemHeight: CGFloat!
        
        //        if Device.IS_IPHONE {
        itemWidth = collectionView.frame.width / 4 - 10.0 // 4 wide
        itemHeight = collectionView.frame.height / 5 - 12.0
        print("Layout for iPhone")
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // MARK - IBAction functions
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        // Begin with new setup
        setupNewGame()
        
        // Shows button at beginning of game
        restartButton.isHidden = false
        playButton.isHidden = true
        playButton.isEnabled = false
        cancelButton.isHidden = true
        cancelButton.isEnabled = false
        
        // Unhides views after start button is pressed
        collectionView.isHidden = false
        bottomView.isHidden = false
    }
    
    // Back button to bring to main menu
    @IBAction func backButtonTapped(_ sender: Any) {
        //        notifications.showNotification(inSeconds: 3, completion: { success in
        //            if success {
        //                print("Successfully scheduled notification")
        //            } else {
        //                print("Error scheduling notification")
        //            }
        //        })
        
        timer?.invalidate()
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController")
        self.show(vc!, sender: self)
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        timer?.invalidate()
        resetGame()
        
        // Shows button at beginning of game
        playButton.isHidden = false
        playButton.isEnabled = true
        
        // Unhides views after start button is pressed
        collectionView.isHidden = true
        bottomView.isHidden = true
    }
    
    func timeString() -> String {
        time = gameController.elapsedTime
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        let milli = Int(time * 100)
        return String(format:"%02d:%02d:%02d", minutes, seconds, milli)
    }
    
    // Updates game time on displays
    @objc func startGameTimer() -> String {
        // Calculate total time since timer started in seconds
        time = gameController.elapsedTime
        
        // Calculate minutes
        let minutes = UInt32(time / 60.0)
        time -= (TimeInterval(minutes) * 60)
        
        // Calculate seconds
        let seconds = UInt32(time)
        time -= TimeInterval(seconds)
        
        // Calculate milliseconds
        let milliseconds = UInt32(time * 100)
        
        // Format time vars with leading zero
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strMilliseconds = String(format: "%02d", milliseconds)
        
        // Add time vars to relevant labels
        display = String(format: "\(strMinutes):\(strSeconds).\(strMilliseconds)", NSLocalizedString("", comment: ""), gameController.elapsedTime)
        
        // Display game time counter
        timerDisplay.text = display
        
        return display
    }
}

extension PokeMatchViewController: GADBannerViewDelegate {
    // MARK: - view positioning
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        if #available(iOS 11.0, *) {
            // In iOS 11, we need to constrain the view to the safe area.
            positionBannerViewFullWidthAtBottomOfSafeArea(bannerView)
        }
        else {
            // In lower iOS versions, safe area is not available so we use
            // bottom layout guide and view edges.
            positionBannerViewFullWidthAtBottomOfView(bannerView)
        }
    }

    @available (iOS 11, *)
    func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
        // Position the banner. Stick it to the bottom of the Safe Area.
        // Make it constrained to the edges of the safe area.
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
            guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
            guide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
            ])
    }

    func positionBannerViewFullWidthAtBottomOfView(_ bannerView: UIView) {
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .leading,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .trailing,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: view.safeAreaLayoutGuide.bottomAnchor,
                                              attribute: .top,
                                              multiplier: 1,
                                              constant: 0))
    }

    // MARK:  AdMob banner ad
    func handleAdRequest() {
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]

        adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(adBannerView)

        adBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"//"ca-app-pub-2292175261120907/6252355617"
        adBannerView.rootViewController = self
        adBannerView.delegate = self

        adBannerView.load(request)
    }

    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
    }

    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error.debugDescription)
    }
    
}
