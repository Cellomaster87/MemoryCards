//
//  Concentration.swift
//  MemoryCards
//
//  Created by Michele Galvagno on 17/06/2019.
//  Copyright © 2019 Michele Galvagno. All rights reserved.
//

import UIKit

enum Points: Int {
    case mismatchPenalty = 1, matchFound
}

class Concentration {
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    var score = 0
    var matchCount = 0
    
    // Keep track of which cards have been seen
    private var seenCards: Set<Int> = []
    
    // Decide what to do when a player taps the card (the else statement will always execute first)
    func chooseCard(at index: Int) {
        flipCount += 1
        
        if !cards[index].isMatched {
            // if we have a card facing up already, check if it matches the chosen one
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // if they match, mark them as matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += Points.matchFound.rawValue
                    matchCount += 1
                } else if seenCards.contains(index) || seenCards.contains(matchIndex) {
                    // cards didn't match, penalise the player
                    score -= Points.mismatchPenalty.rawValue
                }
                // Both cards have been seen, add them to the set.
                seenCards.insert(index)
                seenCards.insert(matchIndex)
                
                // Turn the chosen card face-up
                cards[index].isFaceUp = true
                
                // Since there was a card face-up already (and we selected a new one), we no longer have only 1 card face-up
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // generate the cards for the game
    init(numberOfPairsOfCards: Int) {
        for _ in 0 ..< numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
