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
    @IBOutlet var deal3MoreCardsButton: UIButton!
    
    let game = SetGameModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateView()
    }
    
    @IBAction func didTapButton(_ button: UIButton) {
        let index = cardButtons.index(of: button)
        game.chooseCard(at: index!)
        updateView()
    }
    
    @IBAction func didTapDeal3MoreCards() {
        game.deal3MoreCards()
        updateView()
    }
    
    private func setupView() {
        cardButtons.forEach({ button in
            button.layer.borderWidth = 3.0
            button.layer.cornerRadius = 8.0
            button.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        })
    }
    
    private func updateView() {
        for index in game.cardsInGame.indices {
            let card = game.cardsInGame[index]
            cardButtons[index].setAttributedTitle(getAttributedString(for: card), for: .normal)
            
            if game.matchedCards.contains(card) {
                cardButtons[index].isHidden = true
            } else if game.selectedCards.contains(card) {
                if game.selectedCards.count == 3 {
                    cardButtons[index].layer.borderColor = game.selectedCardIsMatched() ? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                } else {
                    cardButtons[index].layer.borderColor = #colorLiteral(red: 0.9813671708, green: 0.6461395025, blue: 0.1477707922, alpha: 1)
                }
            } else {
                cardButtons[index].layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
        
        deal3MoreCardsButton.isEnabled = (game.cardDeck.count != 0 && (game.cardsInGame.count != 24 || game.selectedCardIsMatched()))
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

