//
//  HighScoreViewController.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit

class HighScoreViewController: UIViewController {
    
    private var pokeMatchViewController: PokeMatchViewController!
    
    @IBOutlet weak var bestTimeStackViews: UIStackView!
    @IBOutlet weak var gameTimeStackView: UIStackView!
    @IBOutlet weak var bestEasyTimeStackView: UIStackView!
    @IBOutlet weak var bestMedTimeStackView: UIStackView!
    @IBOutlet weak var bestHardTimeStackView: UIStackView!
    
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var easyHighScoreLbl: UILabel!
    @IBOutlet weak var mediumHighScoreLbl: UILabel!
    @IBOutlet weak var hardHighScoreLbl: UILabel!
    
    @IBOutlet weak var youWonLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var gcIconView: UIView!
    
    private var score = Int()
    private var easyHighScore = Int()
    private var mediumHighScore = Int()
    private var hardHighScore = Int()
    
    private let easyHighScoreDefault = UserDefaults.standard
    private let mediumHighScoreDefault = UserDefaults.standard
    private let hardHighScoreDefault = UserDefaults.standard
    
    private var minutes = Int()
    private var seconds = Int()
    private var millis = Int()
    
    // Time passed from PokeMatchVC
    var timePassed: String?
    
    private var mute = true
    
    override func viewWillAppear(_ animated: Bool) {
        animateGCIcon()
        loadImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showItems()
        checkHighScoreForNil()
        addScore()
        if timePassed != nil {
            saveHighScore(convertStringToNumbers(time: timePassed!)!)
        } else {
            print("Time is nil")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        gifView.image = nil
    }
    
    // Shows items depending on best score screen or final score screen
    private func showItems() {
        gameTimeStackView.isHidden = false
        playAgainButton.isHidden = false
        menuButton.isHidden = false
    }
    
    private func loadImage() {
        gifView.contentMode = .scaleAspectFit
        gifView.setGifImage(RandomGifs.init().randomGif())
    }
    
    /*************************** High Score Logic *********************/
    
    // Verifies score/time is not nil
    func checkHighScoreForNil() {
        if easyHighScoreDefault.value(forKey: "EasyHighScore") != nil {
            easyHighScore = score
            easyHighScore = easyHighScoreDefault.value(forKey: "EasyHighScore") as! NSInteger
            easyHighScoreLbl.text = "\(intToScoreString(score: easyHighScore))"
        }
        
        if mediumHighScoreDefault.value(forKey: "MedHighScore") != nil {
            mediumHighScore = score
            mediumHighScore = mediumHighScoreDefault.value(forKey: "MedHighScore") as! NSInteger
            mediumHighScoreLbl.text = "\(intToScoreString(score: mediumHighScore))"
        }
        
        if hardHighScoreDefault.value(forKey: "HardHighScore") != nil {
            hardHighScore = score
            hardHighScore = hardHighScoreDefault.value(forKey: "HardHighScore") as! NSInteger
            hardHighScoreLbl.text = "\(intToScoreString(score: hardHighScore))"
        }
    }
    
    // Score format for time
    func intToScoreString(score: Int) -> String {
        minutes = score / 10000
        seconds = (score / 100) % 100
        millis = score % 100
        
        let scoreString = NSString(format: "%02i:%02i.%02i", minutes, seconds, millis) as String
        return scoreString
    }
    
    // Adds time from game to high scores. Compares again others for order
    func addScore() {
        if timePassed != nil {
            menuButton.isHidden = true
            score = Int(convertStringToNumbers(time: timePassed!)!)
            scoreLabel.text = "\(intToScoreString(score: score))"
            
            if defaults.integer(forKey: "difficulty") == 0 {
                if (score < easyHighScore) { // Change value for testing purposes
                    easyHighScore = score
                    easyHighScoreLbl.text = "\(intToScoreString(score: Int(easyHighScore)))"
                }
            } else if defaults.integer(forKey: "difficulty") == 1 {
                if (score < mediumHighScore) { // Change value for testing purposes
                    mediumHighScore = score
                    mediumHighScoreLbl.text = "\(intToScoreString(score: Int(mediumHighScore)))"
                }
            } else if defaults.integer(forKey: "difficulty") == 2 {
                if (score < hardHighScore) { // Change value for testing purposes
                    hardHighScore = score
                    hardHighScoreLbl.text = "\(intToScoreString(score: Int(hardHighScore)))"
                }
            }
            handleHighScore()
        } else {
            gameTimeStackView.isHidden = true
            scoreLabel.isHidden = true
            playAgainButton.isHidden = true
            youWonLabel.isHidden = true
        }
    }
    
    // Handles the saving of high score as cumulative or reset to 0
    func handleHighScore() {
        switch defaults.integer(forKey: "difficulty") {
        case 0:
            easyHighScoreDefault.set(easyHighScore, forKey: "EasyHighScore")
            easyHighScoreDefault.synchronize()
        case 1:
            mediumHighScoreDefault.set(mediumHighScore, forKey: "MedHighScore")
            mediumHighScoreDefault.synchronize()
        case 2:
            hardHighScoreDefault.set(hardHighScore, forKey: "HardHighScore")
            hardHighScoreDefault.synchronize()
        default:
            print("High Score Switch HIT")
            break
        }
    }
    
    // Seperate string out to numbers
    func convertStringToNumbers(time: String) -> Int? {
        let strToInt = time.westernArabicNumeralsOnly
        return Int(strToInt)!
    }
    
    /*************************** GC Animation **********************/
    
    // Animate GC image
    func animateGCIcon() {
        UIView.animate(withDuration: 1.5, animations: {
            self.gcIconView.transform = CGAffineTransform(scaleX: 20, y: 20)
            self.gcIconView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }) { (finished) in
            UIView.animate(withDuration: 0.8, animations: {
                self.gcIconView.transform = CGAffineTransform.identity
            })
        }
    }
    
    /**************************** IBActions ************************/
    
    @IBAction func showGameCenter(_ sender: UIButton) {
        showLeaderboard()
        gifView.image = nil
    }
    
    // Play again game button to main menu
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        // Return to game screen
        gifView.image = nil
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PokeMatchViewController")
        show(vc!, sender: self)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:  Game Center
extension HighScoreViewController: GKGameCenterControllerDelegate {
    /**************************** Game Center ***********************/
    
    // Reporting game time
    func saveHighScore(_ score: Int) {
        // if player is logged in to GC, then report the score
        if GKLocalPlayer.local.isAuthenticated {
            
            var scoreReporter = GKScore()
            
            // Save game time to GC
            if defaults.integer(forKey: "difficulty") == 0 {
                scoreReporter = GKScore(leaderboardIdentifier: easyTimeLeaderboardID)
                scoreReporter.value = Int64(score)
                let gkScoreArray: [GKScore] = [scoreReporter]
                GKScore.report(gkScoreArray, withCompletionHandler: { error in
                    guard error == nil else { return }
                })
            }
            
            if defaults.integer(forKey: "difficulty") == 1 {
                scoreReporter = GKScore(leaderboardIdentifier: mediumTimeLeaderboardID)
                scoreReporter.value = Int64(score)
                let gkScoreArray: [GKScore] = [scoreReporter]
                GKScore.report(gkScoreArray, withCompletionHandler: { error in
                    guard error == nil else { return }
                })
            }
            
            if defaults.integer(forKey: "difficulty") == 2 {
                scoreReporter = GKScore(leaderboardIdentifier: hardTimeLeaderboardID)
                scoreReporter.value = Int64(score)
                let gkScoreArray: [GKScore] = [scoreReporter]
                GKScore.report(gkScoreArray, withCompletionHandler: { error in
                    guard error == nil else { return }
                })
            }
        }
    }
    
    // Retrieves the GC VC leaderboard
    func showLeaderboard() {
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        gameCenterViewController.viewState = .leaderboards
        
        switch defaults.integer(forKey: "difficulty") {
        case 0:
            gameCenterViewController.leaderboardIdentifier = easyTimeLeaderboardID
        case 1:
            gameCenterViewController.leaderboardIdentifier = mediumTimeLeaderboardID
        case 2:
            gameCenterViewController.leaderboardIdentifier = hardTimeLeaderboardID
        default:
            print("Show leaderboard: \(String(describing: gameCenterViewController.leaderboardIdentifier))")
        }
        
        // Show leaderboard
        self.present(gameCenterViewController, animated: true, completion: nil)
    }
    
    // Adds the Done button to the GC view controller
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
