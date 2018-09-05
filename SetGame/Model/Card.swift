//
//  Card.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 29/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation

struct Card: Equatable {
    enum Color: Int, EnumSequence, CardPropertiesMatched {
        typealias T = Color
        case red, green, purple
    }
    enum Number: Int, EnumSequence, CardPropertiesMatched {
        typealias T = Number
        case one, two, three
    }
    enum Symbol: Int, EnumSequence, CardPropertiesMatched {
        typealias T = Symbol
        case diamond, squiggle, oval
    }
    enum Shading: Int, EnumSequence, CardPropertiesMatched {
        typealias T = Shading
        case solid, striped, open
    }
    
    let color: Color
    let number: Number
    let symbol: Symbol
    let shading: Shading
    
    init(color: Color, number: Number, symbol: Symbol, shading: Shading) {
        self.color = color
        self.number = number
        self.symbol = symbol
        self.shading = shading
    }
    
    static func isMatch(cards: [Card]) -> Bool {
        guard cards.count == 3 else { return false }
        let isMatch = Color.isMatch(properties: cards.map({ $0.color })) &&
                      Number.isMatch(properties: cards.map({ $0.number })) &&
                      Symbol.isMatch(properties: cards.map({ $0.symbol })) &&
                      Shading.isMatch(properties: cards.map({ $0.shading }))
        return isMatch
    }
}

protocol CardPropertiesMatched {
    associatedtype T: RawRepresentable where T.RawValue == Int
    static func isMatch(properties: [T]) -> Bool
}

extension CardPropertiesMatched {
    static func isMatch(properties: [T]) -> Bool {
        let sum = properties.map({ $0.rawValue }).reduce(into: 0, { $0 = $0 + $1 })
        return (sum % 3) == 0
    }
}
