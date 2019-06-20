//
//  CardThemes.swift
//  MemoryCards
//
//  Created by Michele Galvagno on 20/06/2019.
//  Copyright © 2019 Michele Galvagno. All rights reserved.
//

import UIKit

enum CardTheme: Int, CaseIterable {
    case Halloween, Flags, Faces, Sports, Animals, Fruits
    
    // determine the color of the back of the card
    var cardColor: UIColor {
        switch self {
        case .Halloween: return #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        case .Flags: return #colorLiteral(red: 0.9607843137, green: 0.7607843137, blue: 0, alpha: 1)
        case .Faces: return #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case .Sports: return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        case .Animals: return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .Fruits: return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            
        @unknown default: return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) 
        }
    }
    
    // determine the color of the background view
    var backgroundColor: UIColor {
        switch self {
        case .Halloween, .Flags, .Faces: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .Sports: return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case .Animals, .Fruits: return #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            
        @unknown default: return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
    
    typealias Emojis = [String]
    // determine the emojis used by each theme
    var emojis: Emojis {
        switch self {
        case .Halloween: return ["👻", "🎃", "🦇", "🙀", "😱", "🍭", "🍬", "🍎", "😰", "😈"]
        case .Flags: return ["🇧🇷", "🇧🇪", "🇯🇵", "🇨🇦", "🇺🇸", "🇵🇪", "🇮🇪", "🇦🇷", "🇮🇹", "🇷🇸"]
        case .Faces: return ["😀", "🙄", "😡", "🤢", "🤡", "😶", "😍", "🤠", "🤪", "🤯"]
        case .Animals: return ["🦊", "🐼", "🦁", "🐘", "🐓", "🦀", "🐷", "🦉", "🦝", "🦢"]
        case .Sports: return ["🏌️", "🤼‍♂️", "🥋", "🏹", "🥊", "🏊", "🤾🏿‍♂️", "🏇🏿", "🤺", "⛹️‍♂️"]
        case .Fruits: return ["🥑", "🍍", "🍓", "🍌", "🍉", "🍇", "🥝", "🍒", "🍈", "🍑"]
        }
    }
}
