//
//  SetGameModel.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 29/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation

class SetGameModel {
    private var cards: [Card]
    private(set) var cardsInGame: [Card]
    private var selectedIndecies: Set<Int> = []
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
        self.cards = cards
        
        cardsInGame = []
        for _ in 0..<12 {
            cardsInGame.append(self.cards.removeRand())
        }
    }
    
    func deal3MoreCards() {
        
    }
    
    func chooseCard(at index: Int) {
        if cardsInGame[index].isSelected {
            cardsInGame[index].isSelected = false
            selectedIndecies.remove(index)
        } else if selectedIndecies.count < 2 {
            cardsInGame[index].isSelected = true
            selectedIndecies.insert(index)
        } else {
            selectedIndecies.insert(index)
            let first = cardsInGame[selectedIndecies.removeFirst()]
            let second = cardsInGame[selectedIndecies.removeFirst()]
            let third = cardsInGame[selectedIndecies.removeFirst()]
            
            if Card.isEqual(first: first, second: second, third: third) {
                selectedIndecies.forEach({ cardsInGame.remove(at: $0) })
                score += 1
            } else {
                selectedIndecies.forEach({ cardsInGame[$0].isSelected = false })
            }
            selectedIndecies = []
        }
    }
}
