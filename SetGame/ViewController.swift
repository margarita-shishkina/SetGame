//
//  ViewController.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 29/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import UIKit

class SetGameViewController: UIViewController {
    @IBOutlet var cardButtons: [UIButton]!
    
    let game = SetGameModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    @IBAction func didTapButton(_ button: UIButton) {
        let index = cardButtons.index(of: button)
        game.chooseCard(at: index!)
        updateView()
    }
    
    private func updateView() {
        for index in game.cardsInGame.indices {
            let card = game.cardsInGame[index]
            cardButtons[index].setAttributedTitle(getAttributedString(for: card), for: .normal)
            if card.isSelected {
                cardButtons[index].layer.borderWidth = 3.0
                cardButtons[index].layer.borderColor = #colorLiteral(red: 0.9813671708, green: 0.6461395025, blue: 0.1477707922, alpha: 1)
            } else {
                cardButtons[index].layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
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
        case .striped: attributes = [.foregroundColor: color.withAlphaComponent(0.15) ]
        }
        
        var symbol: String
        switch card.symbol {
        case .diamond: symbol = "◆"
        case .oval: symbol = "●"
        case .squiggle: symbol = "■"
        }
        
        let symbols: String = [String](repeating: symbol, count: card.nubmer.rawValue + 1).joined(separator: " ")
        
        return NSAttributedString(string: symbols, attributes: attributes)
    }
}

