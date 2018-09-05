//
//  CardButton.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 05/09/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import UIKit

class CardButton: BorderButton {
    var card: Card? { didSet { updateTitle() } }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateTitle()
    }
    
    private func updateTitle() {
        if let card = card {
            setAttributedTitle(getAttributedString(for: card), for: .normal)
            backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            isEnabled = true
        }
        else {
            setAttributedTitle(nil, for: .normal)
            backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            isEnabled = false
        }
    }
    
    private func getAttributedString(for card: Card) -> NSAttributedString {
        var color: UIColor
        switch card.color {
        case .red: color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case .green: color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case .purple: color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        }
        
        var attributes: [NSAttributedStringKey: Any]
        switch card.shading {
        case .open: attributes = [.strokeWidth: 3.0, .strokeColor: color ]
        case .solid: attributes = [.strokeWidth: -3.0, .strokeColor: color, .foregroundColor: color]
        case .striped: attributes = [.strokeWidth: -3.0, .strokeColor: color, .foregroundColor: color.withAlphaComponent(0.15) ]
        }
        
        var symbol: String
        switch card.symbol {
        case .diamond: symbol = "◆"
        case .oval: symbol = "●"
        case .squiggle: symbol = "■"
        }
        
        let separator = traitCollection.verticalSizeClass == .compact ? " " : "\n"
        let symbols = symbol.joined(separator: separator, count: card.number.rawValue + 1)
        return NSAttributedString(string: symbols, attributes: attributes)
    }
}
