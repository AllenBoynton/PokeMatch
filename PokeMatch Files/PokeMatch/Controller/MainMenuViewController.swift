//
//  MainMenuViewController.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit
import SwiftyGif

// Global GC identifiers
let timeLeaderboardID = "com.alsmobileapps.PokeMatch" // Time Leaderboard

class MainMenuViewController: UIViewController {
    
    // Class delegates
    var gameController = PokeMemoryGame()
    var music = Music()
    
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var gifView: UIImageView!
    
    let gifManager = SwiftyGifManager(memoryLimit:20)
    
    let localPlayer = GKLocalPlayer.local
    
    lazy var gcEnabled = Bool() // Check if the user has Game Center enabled
    lazy var gcDefaultLeaderBoard = String() // Check the default
    let GKPlayerAuthenticationDidChangeNotificationName: String = ""
    let score = 0
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        handleGifViews()
        
        if !musicIsOn {
            handleMusicButtons()
        } else {
            bgMusic?.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticatePlayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        gifView.image = nil
    }
    
    // Authenticates the user to access to the GC
    func authenticatePlayer() {
        localPlayer.authenticateHandler = {(view, error) -> Void in
            if view != nil {
                
                // 1. Show login if player is not logged in
                self.present(view!, animated: true, completion: nil)
                
                NotificationCenter.default.addObserver(
                    self, selector: #selector(self.authenticationDidChange(_:)),
                    name: NSNotification.Name(rawValue: self.GKPlayerAuthenticationDidChangeNotificationName),
                    object: nil)
                
            } else if self.localPlayer.isAuthenticated {
                
                // 2. Player is already authenticated & logged in, load game center
                self.gcEnabled = true
                
                // Get the default leaderboard ID
                self.localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifier, error) in
                    if error != nil {
                        print(error as Any)
                    } else {
                        self.gcDefaultLeaderBoard = leaderboardIdentifier!
                    }
                })
            } else {
                // 3. Game center is not enabled on the users device
                self.gcEnabled = false
                print(error.debugDescription)
            }
        }
    }
    
    // Report example score after user logs in
    @objc func authenticationDidChange(_ notification: Notification) {}
    
    // Authentication notification
    func notificationReceived() {
        print("GKPlayerAuthenticationDidChangeNotificationName - Authentication Status: \(localPlayer.isAuthenticated)")
    }
    
    // Reporting game time
    func saveHighScore(_ score: Int64) {
        // if player is logged in to GC, then report the score
        if GKLocalPlayer.local.isAuthenticated {
            
            // Save game time to GC
            let scoreReporter = GKScore(leaderboardIdentifier: timeLeaderboardID)
            scoreReporter.value = Int64(score)
            
            let gkScoreArray: [GKScore] = [scoreReporter]
            
            GKScore.report(gkScoreArray, withCompletionHandler: { error in
                guard error == nil  else { return }
            })
        }
    }
    
    func handleGifViews() {
        gifView.setGifImage(RandomGifs.init().randomFlyingGif(), manager: gifManager, loopCount: -1)
        print("GifImage frame count: \(gifView.gifImage!.framesCount())")
    }
    
    func handleMusicButtons() {
        let image = UIImage(named: "x")
        musicButton.setImage(image, for: .selected)
        if (bgMusic?.isPlaying)! {
            musicButton.alpha = 1.0
            musicButton.isSelected = false
            musicIsOn = true
        } else {
            musicButton.alpha = 0.4
            musicButton.isSelected = true
            musicIsOn = false
        }
    }
    
    // Music button to turn music on/off
    @IBAction func muteButtonTapped(_ sender: UIButton) {
        music.handleMuteMusic(clip: bgMusic)
        handleMusicButtons()
    }
}
