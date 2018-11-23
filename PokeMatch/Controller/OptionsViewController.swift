//
//  OptionsViewController.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import AVFoundation
import GameKit
import StoreKit
import GoogleMobileAds

enum Difficulty {
    case Easy, Medium, Hard
}

class OptionsVC: UIViewController, GKGameCenterControllerDelegate {
    
    // Class delegates
    let music = Music()
    let musicPlayer = AVAudioPlayer()
    let pokeMatchViewController: PokeMatchViewController! = nil
    
    @IBOutlet weak var segmentedControl: DesignableSegmentedControl!
    @IBOutlet var imagePicker: UIPickerView!
    @IBOutlet weak var musicOnView: DesignableViews!
    @IBOutlet weak var musicOffView: DesignableViews!
    @IBOutlet weak var offMusicImage: UIButton!
    
    var bannerView: GADBannerView!
    
    var imageGroupArray: [[UIImage]] = [Array]()
    var imageCategoryArray: [String] = ["Generation 1", "Generation 2", "Generation 3", "Generation 4", "Generation 5", "Generation 6", "Generation 7", "Most Popular"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageGroupArray = [PokeMemoryGame.topCardImages]
        
        self.imagePicker.dataSource = self
        self.imagePicker.delegate = self
        
        handleMusicButtons()
        handleSegmentControl()
        handleAdRequest()
    }
    
    func handleMusicButtons() {
        if (bgMusic?.isPlaying)! {
            musicOnView.layer.borderWidth = 2
            musicOffView.layer.borderWidth = 0
            musicOnView.materialDesign = true
            musicOffView.materialDesign = false
            musicIsOn = true
        } else {
            musicOnView.layer.borderWidth = 0
            musicOffView.layer.borderWidth = 2
            musicOnView.materialDesign = false
            musicOffView.materialDesign = true
            musicIsOn = false
        }
    }
    
    func handleSegmentControl() {
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "Marker Felt", size: 15) as Any,
            NSAttributedStringKey.foregroundColor: UIColor.yellow
            ], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "Marker Felt", size: 15) as Any,
            NSAttributedStringKey.foregroundColor: UIColor.blue
            ], for: .selected)
    }
    
    @IBAction func easyButtonTapped(_ sender: Any) {
        imageGroupArray = [PokeMemoryGame.gen1Images]
        //        pokeMatchViewController.sizeDifficulty(difficulty: .Easy)
    }
    
    @IBAction func mediumButtonTapped(_ sender: Any) {
        //        pokeMatchViewController.sizeDifficulty(difficulty: .Medium)
    }
    
    @IBAction func hardButtonTapped(_ sender: Any) {
        //        pokeMatchViewController.sizeDifficulty(difficulty: .Hard)
    }
    
    @IBAction func musicButtonOn(_ sender: Any) {
        music.handleMuteMusic()
        handleMusicButtons()
    }
    
    @IBAction func musicButtonOff(_ sender: Any) {
        music.handleMuteMusic()
        handleMusicButtons()
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        // Return to game screen
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PokeMatchViewController")
        show(vc!, sender: self)
    }
    
    @IBAction func gcButtonTapped(_ sender: Any) {
        showLeaderboard()
    }
    
    @IBAction func supportButtonTapped(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com/PokeMatchMobileApp/") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func rateButtonTapped(_ sender: Any) {
        print("Rate App button tapped!")
        let appleID = "1241113119"
        guard let writeReviewURL = URL(string: "https://itunes.apple.com/app/id\(appleID)?action=write-review")
            else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
    @IBAction func removeAdButtonTapped(sender: AnyObject) {
        print("Remove Ads Button Tapped")
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // Retrieves the GC VC leaderboard
    func showLeaderboard() {
        let gameCenterViewController = GKGameCenterViewController()
        
        gameCenterViewController.gameCenterDelegate = self
        gameCenterViewController.viewState = .leaderboards
        gameCenterViewController.leaderboardIdentifier = timeLeaderboardID
        
        // Show leaderboard
        self.present(gameCenterViewController, animated: true, completion: nil)
    }
    
    // Adds the Done button to the GC view controller
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}

// asign each button a tag then if/else using the tag and user input
extension OptionsVC {
    //    func onEasyTapped(sender: UIButton) {
    //        pokeMatchViewController.sizeDifficulty(difficulty: .Easy)
    //    }
    //
    //    func onMediumTapped(sender: UIButton) {
    //        pokeMatchViewController.sizeDifficulty(difficulty: .Medium)
    //    }
    //
    //    func onHardTapped(sender: UIButton) {
    //        pokeMatchViewController.sizeDifficulty(difficulty: .Hard)
    //    }
    
    func sizeDifficulty(difficulty: Difficulty) -> (CGFloat, CGFloat) {
        switch difficulty {
        case .Easy:
            print("Easy")
            return (4, 4)
        case .Medium:
            print("Medium")
            return (4, 5)
        case .Hard:
            print("Hard")
            return (5, 6)
        }
    }
    
    func numCardsNeededDifficulty(difficulty: Difficulty) -> Int {
        let (columns, rows) = sizeDifficulty(difficulty: difficulty)
        return Int(columns * rows)
    }
}

extension OptionsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK:  UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return imageCategoryArray.count
        }
        return imageCategoryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    // MARK:  UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageCategoryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(x:0, y:0, width:pickerView.bounds.width - 30, height:60))
        
        let myImageView = UIImageView(frame: CGRect(x:60, y:5, width:50, height:50))
        let myLabel = UILabel(frame: CGRect(x:pickerView.bounds.maxX - 190, y:0, width:pickerView.bounds.width - 90, height:60 ))
        let lockImage = UIImageView(frame: CGRect(x:75, y: 15, width: 35, height: 35))
        var rowString = String()
        let lockImg = UIImage(named: "lock")
        
        switch row {
        case 0:
            rowString = imageCategoryArray[0]
            myImageView.image = UIImage(named:"_25")
            imageGroupArray = [PokeMemoryGame.gen1Images]
        case 1:
            rowString = imageCategoryArray[1]
            myImageView.image = UIImage(named:"_6")
            lockImage.image = lockImg
            imageGroupArray = [PokeMemoryGame.gen2Images]
        case 2:
            rowString = imageCategoryArray[2]
            myImageView.image = UIImage(named:"269")
            lockImage.image = lockImg
            imageGroupArray = [PokeMemoryGame.gen3Images]
        case 3:
            rowString = imageCategoryArray[3]
            myImageView.image = UIImage(named:"_448")
            lockImage.image = lockImg
            imageGroupArray = [PokeMemoryGame.gen4Images]
        case 4:
            rowString = imageCategoryArray[4]
            myImageView.image = UIImage(named:"_133")
            lockImage.image = lockImg
            imageGroupArray = [PokeMemoryGame.gen5Images]
        case 5:
            rowString = imageCategoryArray[5]
            myImageView.image = UIImage(named:"_249")
            lockImage.image = lockImg
            imageGroupArray = [PokeMemoryGame.gen6Images]
        case 6:
            rowString = imageCategoryArray[6]
            myImageView.image = UIImage(named:"_257")
            lockImage.image = lockImg
            imageGroupArray = [PokeMemoryGame.gen7Images]
        case 7:
            rowString = imageCategoryArray[7]
            myImageView.image = UIImage(named:"_384")
            lockImage.image = lockImg
            imageGroupArray = [PokeMemoryGame.topCardImages]
        case 8: break
        default:
            rowString = "Error: too many rows"
            myImageView.image = nil
        }
        
        myLabel.text = rowString
        
        myView.addSubview(myLabel)
        myView.addSubview(myImageView)
        myView.addSubview(lockImage)
        
        return myView
    }
}

extension OptionsVC: GADBannerViewDelegate {
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
    
    // MARK: - view positioning
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
    
    // AdMob banner ad
    func handleAdRequest() {
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"//"ca-app-pub-2292175261120907/4964310398"
        bannerView.rootViewController = self
        bannerView.delegate = self
        
        bannerView.load(request)
    }
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
        //        music.handleMuteMusic()
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
        //        music.handleMuteMusic()
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
