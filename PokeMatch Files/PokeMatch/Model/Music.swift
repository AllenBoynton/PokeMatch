//
//  Music.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import AVFoundation
import GoogleMobileAds

// Global references
var bgMusic: AVAudioPlayer?
var winnerAudio: AVAudioPlayer?
var musicIsOn = true

class Music {
    
    // MARK: Sound files
    func startGameMusic() {
        // BG music
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
        
        do {
            bgMusic = try AVAudioPlayer(contentsOf: url)
            bgMusic?.prepareToPlay()
            bgMusic?.play()
            bgMusic?.numberOfLoops = -1
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    func playWinnerAudio() {
        // Winning music
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "fanfare", ofType: "mp3")!)
        
        do {
            winnerAudio = try AVAudioPlayer(contentsOf: url)
            winnerAudio?.prepareToPlay()
            winnerAudio?.play()
            winnerAudio?.numberOfLoops = 0
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
}

extension Music {
    // Pause sound during ads
    func handleMuteMusic() {
        // Pause sound if on
        if musicIsOn {
            // pauses music
            GADMobileAds.sharedInstance().applicationMuted = true
            bgMusic?.pause()
            winnerAudio?.stop()
            musicIsOn = false
            print("Audio muted")
        } else {
            bgMusic?.play()
            musicIsOn = true
            print("Audio playing")
        }
    }
}
