//
//  SetGameModel.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 29/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation

class SetGameModel {
    private(set) var cardDeck: [Card]
    private(set) var cardsInGame: [Card]
    private(set) var selectedCards: [Card] = []
    private(set) var matchedCards: [Card] = []
    private(set) var score = 0
    
    init() {
        var cards: [Card] = []
        Card.Color.all().forEach({ color in
            Card.Number.all().forEach({ number in
                Card.Shading.all().forEach({ shading in
                    Card.Symbol.all().forEach({ symbol in
                        cards.append(Card(color: color, number: number, symbol: symbol, shading: shading))
                    })
                })
            })
        })
        self.cardDeck = cards
        
        cardsInGame = []
        for _ in 0..<12 {
            cardsInGame.append(self.cardDeck.removeRand())
        }
    }
    
    func deal3MoreCards() {
        if selectedCardIsMatched() {
            replaceSelectedCards()
            selectedCards = []
        } else if cardDeck.count != 0 {
            (0..<3).forEach({ _ in cardsInGame.append(cardDeck.removeRand()) })
        }
    }
    
    func chooseCard(at index: Int) {
        let card = cardsInGame[index]
        if let selectedIndex = selectedCards.index(of: card), selectedCards.count < 3 {
            selectedCards.remove(at: selectedIndex)
        } else if selectedCards.count < 2 {
            selectedCards.append(card)
        } else if selectedCards.count == 2 {
            let fisrt = selectedCards[0]
            let second = selectedCards[1]
            if Card.isMatch(first: fisrt, second: second, third: card) {
                matchedCards += [fisrt, second, card]
            }
            selectedCards.append(card)
        } else if selectedCards.count == 3 {
            if selectedCardIsMatched() { replaceSelectedCards() }
            selectedCards = [card]
        }
    }
    
    func selectedCardIsMatched() -> Bool {
        return selectedCards.filter({ matchedCards.contains($0) }).count == 3
    }
    
    private func replaceSelectedCards() {
        if cardDeck.count == 0 { return }
        selectedCards.forEach({ card in
            let index = cardsInGame.index(of: card)
            cardsInGame[index!] = cardDeck.removeRand()
        })
    }
}
