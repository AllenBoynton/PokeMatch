//
//  MemoryGameDelegate.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import Foundation

// MARK: - MemoryGameDelegate

protocol MemoryGameDelegate {
    func memoryGameDidStart(_ game: PokeMemoryGame)
    func memoryGame(_ game: PokeMemoryGame, showCards cards: [Card])
    func memoryGame(_ game: PokeMemoryGame, hideCards cards: [Card])
    func memoryGameDidEnd(_ game: PokeMemoryGame, elapsedTime: TimeInterval)
}
