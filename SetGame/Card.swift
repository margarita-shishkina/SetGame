//
//  Card.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 29/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation

struct Card {
    enum Color: Int, EnumSequence, CardFeaturesEquatable {
        typealias T = Color
        case red, green, purple
    }
    enum Number: Int, EnumSequence, CardFeaturesEquatable {
        typealias T = Number
        case one, two, three
    }
    enum Symbol: Int, EnumSequence, CardFeaturesEquatable {
        typealias T = Symbol
        case diamond, squiggle, oval
    }
    enum Shading: Int, EnumSequence, CardFeaturesEquatable {
        typealias T = Shading
        case solid, striped, open
    }
    
    let color: Color
    let nubmer: Number
    let symbol: Symbol
    let shading: Shading

    var isSelected = false
    
    init(color: Color, number: Number, symbol: Symbol, shading: Shading) {
        self.color = color
        self.nubmer = number
        self.symbol = symbol
        self.shading = shading
    }
    
    static func isEqual(first: Card, second: Card, third: Card) -> Bool {
        return Color.isEqual(first: first.color, second: second.color, third: third.color)
               && Number.isEqual(first: first.nubmer, second: second.nubmer, third: third.nubmer)
               && Symbol.isEqual(first: first.symbol, second: second.symbol, third: third.symbol)
               && Shading.isEqual(first: first.shading, second: second.shading, third: third.shading)
    }
}

protocol CardFeaturesEquatable {
    associatedtype T: RawRepresentable where T.RawValue == Int
    static func isEqual(first: T, second: T, third: T) -> Bool
}

extension CardFeaturesEquatable {
    static func isEqual(first: T, second: T, third: T) -> Bool {
        if first == second && second == third {
            return true
        } else if first != second && second != third && first != third {
            return true
        } else {
            return false
        }
    }
}
