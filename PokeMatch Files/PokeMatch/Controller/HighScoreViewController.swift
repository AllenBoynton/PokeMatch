//
//  HighScoreViewController.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit

// Global GC identifiers
let easyTimeLeaderboardID = "com.alsmobileapps.PokeMatch" // Easy Time Leaderboard
let mediumTimeLeaderboardID = "com.alsmobileapps.PokeMatch.medium" // Medium Time Leaderboard
let hardTimeLeaderboardID = "com.alsmobileapps.PokeMatch.hard" // Hard Time Leaderboard
let overallTimeLeaderboardID = "com.alsmobileapps.PokeMatch.overall" // Total Time Leaderboard
let gamesAchievementID10 = "achievements.pokematch.10"
let gamesAchievementID20 = "achievements.pokematch.20"
let gamesAchievementID30 = "achievements.pokematch.30"
let gamesAchievementID40 = "achievements.pokematch.40"
let gamesAchievementID50 = "achievements.pokematch.50"
let gamesAchievementID100 = "achievements.pokematch.100"
let gamesAchievementID150 = "achievements.pokematch.150"
let gamesAchievementID200 = "achievements.pokematch.200"
let gamesAchievementID250 = "achievements.pokematch.250"
let gamesAchievementID300 = "achievements.pokematch.300"
let gamesAchievementID350 = "achievements.pokematch.350"
let gamesAchievementID400 = "achievements.pokematch.400"
let gamesAchievementID450 = "achievements.pokematch.450"
let gamesAchievementID500 = "achievements.pokematch.500"

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
    
    private var scoreReporter = GKScore()
    private var score = Int()
    private var easyHighScore = Int()
    private var mediumHighScore = Int()
    private var hardHighScore = Int()
    private var numOfGames = 0
    
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
        numOfGames = defaults.integer(forKey: "Games")
        showTime()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        gifView.image = nil
    }
    
    private func showTime() {
        if timePassed != nil {
            let numTime = convertStringToNumbers(time: timePassed!)!
            saveHighScore(numTime)
            print("Achievement Time: \(numTime)")
            if numTime <= 3000 {
                numOfGames += 1
                defaults.set(numOfGames, forKey: "Games")
                defaults.synchronize()
                handleGameAchievements()
                print("Number of games under 30 seconds: \(defaults.integer(forKey: "Games"))")
            }
        } else {
            print("Time is nil")
        }
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
        if defaults.value(forKey: "EasyHighScore") != nil {
            easyHighScore = score
            easyHighScore = defaults.value(forKey: "EasyHighScore") as! NSInteger
            easyHighScoreLbl.text = "\(intToScoreString(score: easyHighScore))"
        }
        if defaults.value(forKey: "MedHighScore") != nil {
            mediumHighScore = score
            mediumHighScore = defaults.value(forKey: "MedHighScore") as! NSInteger
            mediumHighScoreLbl.text = "\(intToScoreString(score: mediumHighScore))"
        }
        if defaults.value(forKey: "HardHighScore") != nil {
            hardHighScore = score
            hardHighScore = defaults.value(forKey: "HardHighScore") as! NSInteger
            hardHighScoreLbl.text = "\(intToScoreString(score: hardHighScore))"
        }
        defaults.synchronize()
    }
    
    // Score format for time
    func intToScoreString(score: Int) -> String {
        minutes = score / 10000
        seconds = (score / 100) % 100
        millis = score % 100
        
        let scoreString = NSString(format: "%02i:%02i.%02i", minutes, seconds, millis) as String
        return scoreString
    }
    
    // Adds time from game to high scores. Compares against others for order
    func addScore() {
        if timePassed != nil {
            menuButton.isHidden = true
            score = Int(convertStringToNumbers(time: timePassed!)!)
            scoreLabel.text = "\(intToScoreString(score: score))"
            print("Default difficulty: \(defaults.integer(forKey: "difficulty"))")
            
            if defaults.integer(forKey: "difficulty") == 0 {
                if (easyHighScore == 0) { // Change value for testing purposes
                    easyHighScoreLbl.text = "\(intToScoreString(score: Int(score)))"
                }
                
                if (score < easyHighScore) {
                    easyHighScore = score
                    easyHighScoreLbl.text = "\(intToScoreString(score: Int(easyHighScore)))"
                }
            }
            
            if defaults.integer(forKey: "difficulty") == 1 {
                if (mediumHighScore == 0) { // Change value for testing purposes
                    mediumHighScoreLbl.text = "\(intToScoreString(score: Int(score)))"
                }
                
                if (score < mediumHighScore) { // Change value for testing purposes
                    mediumHighScore = score
                    mediumHighScoreLbl.text = "\(intToScoreString(score: Int(mediumHighScore)))"
                }
            }
            
            if defaults.integer(forKey: "difficulty") == 2 {
                if (hardHighScore == 0) { // Change value for testing purposes
                    hardHighScoreLbl.text = "\(intToScoreString(score: Int(score)))"
                }
                
                if (score < hardHighScore) && (hardHighScore > 0) { // Change value for testing purposes
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
            defaults.set(easyHighScore, forKey: "EasyHighScore")
        case 1:
            defaults.set(mediumHighScore, forKey: "MedHighScore")
        case 2:
            defaults.set(hardHighScore, forKey: "HardHighScore")
        default:
            print("High Score Switch HIT")
            break
        }
        defaults.synchronize()
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
            // Save game time to GC
            if defaults.integer(forKey: "difficulty") == 0 {
                handleScoreReporter(id: easyTimeLeaderboardID)
//                scoreReporter = GKScore(leaderboardIdentifier: easyTimeLeaderboardID)
//                scoreReporter.value = Int64(score)
//                let gkScoreArray: [GKScore] = [scoreReporter]
//                GKScore.report(gkScoreArray, withCompletionHandler: { error in
//                    guard error == nil else { return }
//                })
            }
            
            if defaults.integer(forKey: "difficulty") == 1 {
                handleScoreReporter(id: mediumTimeLeaderboardID)
//                scoreReporter = GKScore(leaderboardIdentifier: mediumTimeLeaderboardID)
//                scoreReporter.value = Int64(score)
//                let gkScoreArray: [GKScore] = [scoreReporter]
//                GKScore.report(gkScoreArray, withCompletionHandler: { error in
//                    guard error == nil else { return }
//                })
            }
            
            if defaults.integer(forKey: "difficulty") == 2 {
                handleScoreReporter(id: hardTimeLeaderboardID)
//                scoreReporter = GKScore(leaderboardIdentifier: hardTimeLeaderboardID)
//                scoreReporter.value = Int64(score)
//                let gkScoreArray: [GKScore] = [scoreReporter]
//                GKScore.report(gkScoreArray, withCompletionHandler: { error in
//                    guard error == nil else { return }
//                })
            }
        }
    }
    
    private func handleScoreReporter(id: String) {
        scoreReporter = GKScore(leaderboardIdentifier: id)
        scoreReporter.value = Int64(score)
        let gkScoreArray: [GKScore] = [scoreReporter]
        GKScore.report(gkScoreArray, withCompletionHandler: { error in
            guard error == nil else { return }
        })
    }
    
    // Retrieves the GC VC leaderboard
    private func showLeaderboard() {
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        gameCenterViewController.viewState = .default
        
//        switch defaults.integer(forKey: "difficulty") {
//        case 0:
//            gameCenterViewController.leaderboardIdentifier = easyTimeLeaderboardID
//        case 1:
//            gameCenterViewController.leaderboardIdentifier = mediumTimeLeaderboardID
//        case 2:
//            gameCenterViewController.leaderboardIdentifier = hardTimeLeaderboardID
//        default:
//            print("Show leaderboard: \(String(describing: gameCenterViewController.leaderboardIdentifier))")
//        }
        
        // Show leaderboard
        self.present(gameCenterViewController, animated: true, completion: nil)
    }
    
    // Adds the Done button to the GC view controller
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func handleGameAchievements() {
        if GKLocalPlayer.local.isAuthenticated {
            let games = defaults.integer(forKey: "Games")
            
            switch games {
            case 10:
                let achievement = GKAchievement(identifier: gamesAchievementID10)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 20:
                let achievement = GKAchievement(identifier: gamesAchievementID20)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 30:
                let achievement = GKAchievement(identifier: gamesAchievementID30)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 40:
                let achievement = GKAchievement(identifier: gamesAchievementID40)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 50:
                let achievement = GKAchievement(identifier: gamesAchievementID50)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 100:
                let achievement = GKAchievement(identifier: gamesAchievementID100)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 150:
                let achievement = GKAchievement(identifier: gamesAchievementID150)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 200:
                let achievement = GKAchievement(identifier: gamesAchievementID200)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 250:
                let achievement = GKAchievement(identifier: gamesAchievementID250)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 300:
                let achievement = GKAchievement(identifier: gamesAchievementID300)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 350:
                let achievement = GKAchievement(identifier: gamesAchievementID350)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 400:
                let achievement = GKAchievement(identifier: gamesAchievementID400)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 450:
                let achievement = GKAchievement(identifier: gamesAchievementID450)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            case 500:
                let achievement = GKAchievement(identifier: gamesAchievementID500)
                achievement.percentComplete = Double((games / 500) * 100)
                achievement.showsCompletionBanner = true
                GKAchievement.report([achievement], withCompletionHandler: nil)
            default:
                print(print("Achievements default reached"))
            }
        }
        
        GKAchievement.loadAchievements() { achievements, error in
            guard let achievements = achievements else { return }
            print(achievements)
        }
    }
}
