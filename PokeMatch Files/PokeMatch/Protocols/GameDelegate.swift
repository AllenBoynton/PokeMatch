//
//  MemoryGameDelegate.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import Foundation

// MARK: - MemoryGameDelegate

protocol GameDelegate {
    func memoryGameDidStart(_ game: MemoryGame)
    func memoryGame(_ game: MemoryGame, showCards cards: [Card])
    func memoryGame(_ game: MemoryGame, hideCards cards: [Card])
    func memoryGameDidEnd(_ game: MemoryGame, elapsedTime: TimeInterval)
}
