//
//  ViewController.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 29/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import UIKit

class SetGameViewController: UIViewController {
    @IBOutlet var cardButtons: [CardButton]!
    @IBOutlet var deal3MoreCardsButton: UIButton!
    
    let game = SetGameModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    @IBAction func didTapButton(_ button: CardButton) {
        let index = cardButtons.index(of: button)
        game.chooseCard(at: index!)
        updateView()
    }
    
    @IBAction func didTapDeal3MoreCards() {
        game.deal3MoreCards()
        updateView()
    }
    
    @IBAction func didTapHint() {
        game.findMatch()
        updateView()
    }
    
    private func updateView() {
        for index in game.cardsInGame.indices {
            let card = game.cardsInGame[index]
            cardButtons[index].card = card
            
            guard card != nil else {
                cardButtons[index].borderColor = .clear
                continue
            }
            if game.selectedCards.contains(card!) {
                if game.selectedCards.count == 3 {
                    cardButtons[index].borderColor = game.selectedCardIsMatched() ? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                } else {
                    cardButtons[index].borderColor = #colorLiteral(red: 0.9813671708, green: 0.6461395025, blue: 0.1477707922, alpha: 1)
                }
            } else if game.matchCards.contains(card!) {
                cardButtons[index].borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            } else {
                cardButtons[index].borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
        
        deal3MoreCardsButton.isEnabled = (!game.cardDeck.isEmpty && (game.cardsInGame.count != 24 || game.selectedCardIsMatched()))
    }
}

