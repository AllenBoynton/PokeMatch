//
//  ModelTests.swift
//  PokeMatchTests
//
//  Created by Allen Boynton on 1/17/19.
//  Copyright © 2019 Allen Boynton. All rights reserved.
//

import Foundation
import XCTest
@testable import PokeMatch

class ModelTests: XCTestCase {
    
    func testStartMusic() {
        let audio = Music.init()
        audio.startGameMusic(name: "music")
    }
    
    func testMuteMusic() {
        let sound = Music.init()
        sound.playWinnerAudio1()
    }
    
    func testIfMusicIsOff() {
        let music = Music.init()
        music.handleMuteMusic(clip: bgMusic)
        
        XCTAssertFalse(musicIsOn)
    }
}
