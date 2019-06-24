//
//  Card.swift
//  MemoryCards
//
//  Created by Michele Galvagno on 17/06/2019.
//  Copyright © 2019 Michele Galvagno. All rights reserved.
//

import Foundation

struct Card: Hashable {
    // These properties need to be public
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
