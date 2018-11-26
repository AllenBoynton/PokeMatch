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
var bgMusic2: AVAudioPlayer?
var winnerAudio1: AVAudioPlayer?
var winnerAudio2: AVAudioPlayer?
var winnerAudio3: AVAudioPlayer?
var winnerAudioArray: [AVAudioPlayer]?
var musicIsOn = true

class Music {
    
    // MARK: Sound files
    func startGameMusic(name: String) {
        // BG music
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "mp3")!)
        
        do {
            bgMusic = try AVAudioPlayer(contentsOf: url)
            bgMusic?.prepareToPlay()
            bgMusic?.play()
            bgMusic?.numberOfLoops = -1
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    func startGameMusic2() {
        // Winning music
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "90 Ending Theme", ofType: "mp3")!)
        
        do {
            bgMusic2 = try AVAudioPlayer(contentsOf: url)
            bgMusic2?.prepareToPlay()
            bgMusic2?.play()
            bgMusic2?.numberOfLoops = 0
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    func playWinnerAudio1() {
        // Winning music
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "fanfare", ofType: "mp3")!)
        
        do {
            winnerAudio1 = try AVAudioPlayer(contentsOf: url)
            winnerAudio1?.prepareToPlay()
            winnerAudio1?.play()
            winnerAudio1?.numberOfLoops = 0
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    func playWinnerAudio2() {
        // Winning music
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "42 Fanfare_ Jackpot", ofType: "mp3")!)
        
        do {
            winnerAudio2 = try AVAudioPlayer(contentsOf: url)
            winnerAudio2?.prepareToPlay()
            winnerAudio2?.play()
            winnerAudio2?.numberOfLoops = 0
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    func playWinnerAudio3() {
        // Winning music
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "54 Fanfare_ Pokémon Caught", ofType: "mp3")!)
        
        do {
            winnerAudio3 = try AVAudioPlayer(contentsOf: url)
            winnerAudio3?.prepareToPlay()
            winnerAudio3?.play()
            winnerAudio3?.numberOfLoops = 0
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
}

extension Music {
    // Pause sound during ads
    func handleMuteMusic(clip: AVAudioPlayer?) {
        // Pause sound if on
        if musicIsOn {
            // pauses music
            GADMobileAds.sharedInstance().applicationMuted = true
            clip?.pause()
            winnerAudio1?.stop()
            musicIsOn = false
            print("Audio muted")
        } else {
            clip?.play()
            musicIsOn = true
            print("Audio playing")
        }
    }
}
