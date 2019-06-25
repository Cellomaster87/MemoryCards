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

struct Concentration {
    // this has to be public for other files to use but this file is responsible for setting it.
    private(set) var cards = [Card]()
    
    // since we moved this here in the homework we cannot make it private
    var flipCount = 0
    var score = 0
    var matchCount = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for (index, _) in cards.enumerated() {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    private var seenCards: Set<Int> = []
    
    // Decide what to do when a player taps the card (the else statement will always execute first)
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        flipCount += 1
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += Points.matchFound.rawValue
                    matchCount += 1
                } else if seenCards.contains(index) || seenCards.contains(matchIndex) {
                    score -= Points.mismatchPenalty.rawValue
                }
                seenCards.insert(index)
                seenCards.insert(matchIndex)
                
                cards[index].isFaceUp = true
            } else {
                // this happens if the tapped card is the first one to be flipped.
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // generate the cards for the game
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        for _ in 0 ..< numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] // they will have the same identifier!
        }
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
