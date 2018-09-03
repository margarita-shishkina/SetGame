//
//  Card.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 29/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation

struct Card: Equatable {
    enum Color: Int, EnumSequence, CardFeaturesMatched {
        typealias T = Color
        case red, green, purple
    }
    enum Number: Int, EnumSequence, CardFeaturesMatched {
        typealias T = Number
        case one, two, three
    }
    enum Symbol: Int, EnumSequence, CardFeaturesMatched {
        typealias T = Symbol
        case diamond, squiggle, oval
    }
    enum Shading: Int, EnumSequence, CardFeaturesMatched {
        typealias T = Shading
        case solid, striped, open
    }
    
    let color: Color
    let nubmer: Number
    let symbol: Symbol
    let shading: Shading
    
    init(color: Color, number: Number, symbol: Symbol, shading: Shading) {
        self.color = color
        self.nubmer = number
        self.symbol = symbol
        self.shading = shading
    }
    
    static func isMatch(first: Card, second: Card, third: Card) -> Bool {
        return Color.isMatch(first: first.color, second: second.color, third: third.color)
               && Number.isMatch(first: first.nubmer, second: second.nubmer, third: third.nubmer)
               && Symbol.isMatch(first: first.symbol, second: second.symbol, third: third.symbol)
               && Shading.isMatch(first: first.shading, second: second.shading, third: third.shading)
    }
}

protocol CardFeaturesMatched {
    associatedtype T: RawRepresentable where T.RawValue == Int
    static func isMatch(first: T, second: T, third: T) -> Bool
}

extension CardFeaturesMatched {
    static func isMatch(first: T, second: T, third: T) -> Bool {
        if first == second && second == third {
            return true
        } else if first != second && second != third && first != third {
            return true
        } else {
            return false
        }
    }
}
