//
//  ViewController.swift
//  MemoryCards
//
//  Created by Michele Galvagno on 27/05/2019.
//  Copyright © 2019 Michele Galvagno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private var emojiChoices = [String]()
    private var emoji = [Int : String]()
    
    var backgroundColor: UIColor!
    var cardColor: UIColor!

    @IBOutlet private var flipCountLabel: UILabel!
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private var newGameButton: UIButton!
    
    // MARK: - View Management
    override func viewDidLoad() {
        super.viewDidLoad()        
        newGame()
    }
    
    private func updateViewFromModel() {
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
            
            if card.isMatched {
                UIView.animate(withDuration: 1) {
                    button.alpha = 0
                }
            }
            
            if button.backgroundColor?.cgColor.alpha == 0 {
                button.isEnabled = false
            }
        }
        
        if game.matchCount == game.cards.count / 2 {
            let gameOverAC = UIAlertController(title: "Congratulations!", message: "Your score is \(game.score)!", preferredStyle: .alert)
            gameOverAC.addAction(UIAlertAction(title: "Start New Game!", style: .default) { [weak self] _ in
                self?.newGame()
            })
            
            scoreLabel.alpha = 0
            flipCountLabel.alpha = 0
            newGameButton.alpha = 0
            
            present(gameOverAC, animated: true)
        }
    }

    // MARK: - Action METHODS
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
            // this should just never happen
        }
    }
    
    @IBAction private func newGamePressed(_ sender: UIButton!) {
        newGame()
    }
    
    // MARK: - Helper METHODS
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, !emojiChoices.isEmpty {
            let randomIndex = Int.random(in: 0 ..< emojiChoices.count)
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex) // populate the dictionary 
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    private func newGame() {
        emojiChoices = []
        emoji = [:]
        
        game.flipCount = 0
        game.score = 0
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        
        updateViewFromModel()
        
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
                
                UIView.animate(withDuration: 1) {
                    cardButton.alpha = 1
                    self.newGameButton.alpha = 1
                    self.scoreLabel.alpha = 1
                    self.flipCountLabel.alpha = 1
                }
            }
        }
    }
}
