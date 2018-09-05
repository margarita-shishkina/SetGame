//
//  Utils.swift
//  SetGameTests
//
//  Created by Margarita Sergeevna on 03/09/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation
@testable import SetGame

struct Utils {
    static func findMatchIndecies(cards: [Card?]) -> [Int]? {
        let count = cards.count
        for i in 0..<(count-2) {
            for j in i+1..<(count-1) {
                for k in j+1..<count {
                    guard let first = cards[i], let second = cards[j], let third = cards[k] else { continue }
                    if Card.isMatch(cards: [first, second, third ]) {
                        return [i, j, k]
                    }
                }
            }
        }
        return nil
    }
    
    static func getRandNotMatchIndex(mathedIndecies: [Int], cards: [Card?]) -> Int {
        while true {
            let rand = cards.count.rand
            if !mathedIndecies.contains(rand) && cards[rand] != nil {
                return rand
            }
        }
    }
}
