//
//  Deck.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 04/09/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation

struct Deck {
    private var cards: [Card] = []
    
    init() {
        Card.Color.all().forEach({ color in
            Card.Number.all().forEach({ number in
                Card.Shading.all().forEach({ shading in
                    Card.Symbol.all().forEach({ symbol in
                        cards.append(Card(color: color, number: number, symbol: symbol, shading: shading))
                    })
                })
            })
        })
    }
    
    var isEmpty: Bool { return cards.isEmpty }
    
    mutating func drawRand() -> Card? {
        if cards.count > 0 {
            return cards.removeRand()
        } else {
            return nil
        }
    }
    
    mutating func drawRand(n: Int) -> [Card] {
        return (0..<n).compactMap({ _  -> Card? in drawRand() })
    }
}
