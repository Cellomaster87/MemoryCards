//
//  ViewController.swift
//  MemoryCards
//
//  Created by Michele Galvagno on 27/05/2019.
//  Copyright © 2019 Michele Galvagno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - PROPERTIES and OUTLETS
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var emojiChoices: [String] = CardTheme.Halloween.emojis
    var emoji = [Int : String]()
    
    var backgroundColor: UIColor!
    var cardColor: UIColor!

    @IBOutlet var flipCountLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet var newGameButton: UIButton!
    
    // MARK: - View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        for cardButton in cardButtons {
            cardButton.backgroundColor = cardColor ?? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        }
    }
    
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        
        for (index, button) in cardButtons.enumerated() {
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : (cardColor ?? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1))
            }
            
            if button.backgroundColor?.cgColor.alpha == 0 {
                button.isEnabled = false
            }
        }
    }

    // MARK: - Action METHODS
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
            // this should just never happen
        }
    }
    
    @IBAction func newGame(_ sender: UIButton!) {
        emojiChoices = []
        emoji = [:]
        
        game.flipCount = 0
        game.score = 0
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        
        updateViewFromModel() // bingo!
        
        if let randomTheme = CardTheme(rawValue: Int.random(in: 0 ... CardTheme.allCases.count - 1)) {
            emojiChoices = randomTheme.emojis
            backgroundColor = randomTheme.backgroundColor
            view.backgroundColor = backgroundColor
            
            cardColor = randomTheme.cardColor
            flipCountLabel.textColor = cardColor
            scoreLabel.textColor = cardColor
            newGameButton.setTitleColor(cardColor, for: .normal)
            
            for cardButton in cardButtons {
                cardButton.backgroundColor = cardColor
                cardButton.setTitle("", for: .normal)
                cardButton.isEnabled = true
            }
        }
    }
    
    // MARK: - Helper METHODS
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, !emojiChoices.isEmpty {
            let randomIndex = Int.random(in: 0 ..< emojiChoices.count)
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex) // populate the dictionary 
        }
        
        return emoji[card.identifier] ?? "?"
    }
}
