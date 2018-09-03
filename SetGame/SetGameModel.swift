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
            matchedCards.append(contentsOf: selectedCards)
            replaceSelectedCards()
            selectedCards = []
        } else {
            appendCards()
        }
    }
    
    func chooseCard(at index: Int) {
        let card = cardsInGame[index]
        if selectedCards.count < 3 {
            if let selectedIndex = selectedCards.index(of: card) {
                selectedCards.remove(at: selectedIndex)
            } else {
                selectedCards.append(card)
            }
        } else {
            if selectedCardIsMatched() {
                matchedCards.append(contentsOf: selectedCards)
                replaceSelectedCards()
            }
            selectedCards = [card]
        }
    }
    
    func selectedCardIsMatched() -> Bool {
        if selectedCards.count < 3 { return false }
        return Card.isMatch(first: selectedCards[0], second: selectedCards[1], third: selectedCards[2])
    }
    
    private func replaceSelectedCards() {
        if cardDeck.count == 0 { return }
        selectedCards.forEach({ card in
            let index = cardsInGame.index(of: card)
            cardsInGame[index!] = cardDeck.removeRand()
        })
    }
    
    private func appendCards() {
        if cardDeck.count == 0 { return }
        (0..<3).forEach({ _ in cardsInGame.append(cardDeck.removeRand()) })
    }
}
