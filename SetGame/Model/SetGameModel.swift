
//
//  SetGameModel.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 29/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation

class SetGameModel {
    private(set) var cardDeck: Deck = Deck()
    private(set) var cardsInGame: [Card?]
    private(set) var selectedCards: [Card] = []
    private(set) var matchCards: [Card] = []
    private(set) var score = 0
    
    init() {
        cardsInGame = cardDeck.drawRand(n: 12)
    }
    
    func deal3MoreCards() {
        if selectedCardIsMatched() {
            replaceOrRemoveSelectedCards()
            selectedCards = []
        } else {
            appendCards()
        }
    }
    
    func chooseCard(at index: Int) {
        guard let card = cardsInGame[index] else { return }
        
        if selectedCards.count < 3 {
            if let selectedIndex = selectedCards.index(of: card) {
                selectedCards.remove(at: selectedIndex)
            } else {
                selectedCards.append(card)
            }
        } else {
            if selectedCardIsMatched() {
                replaceOrRemoveSelectedCards()
            }
            selectedCards = [card]
        }
    }
    
    func selectedCardIsMatched() -> Bool {
        if selectedCards.count < 3 { return false }
        return Card.isMatch(cards: selectedCards)
    }
    
    func findMatch() {
        Utils.findMatchIndecies(cards: cardsInGame)?.forEach({ matchCards.append(cardsInGame[$0]!) })
    }
    
    private func replaceOrRemoveSelectedCards() {
        if cardDeck.isEmpty {
            selectedCards.forEach({ selectedCard in
                if let index = cardsInGame.index(of: selectedCard) {
                    cardsInGame[index] = nil
                }
            })
        } else {
            cardsInGame.replace(selectedCards, with: cardDeck.drawRand(n: selectedCards.count))
        }
    }
    
    private func appendCards() {
        cardsInGame.append(contentsOf: cardDeck.drawRand(n: 3)) 
    }
}
