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
    static func findMatch(cards: [Card], matched: [Card]) -> (first: Int, second: Int, third: Int)? {
        let count = cards.count
        for i in 0..<(count-2) {
            for j in i+1..<(count-1) {
                for k in j+1..<count {
                    let first = cards[i]
                    let second = cards[j]
                    let third = cards[k]
                    if Card.isMatch(first: first, second: second, third: third) && !matched.contains(first) && !matched.contains(second) && !matched.contains(third) {
                        return (i, j, k)
                    }
                }
            }
        }
        return nil
    }
    
    static func getRandNotMatchIndex(mathedIndecies: (first: Int, second: Int, third: Int), cards: [Card]) -> Int {
        while true {
            let rand = cards.count.rand
            if rand != mathedIndecies.first && rand != mathedIndecies.second && rand != mathedIndecies.third {
                return rand
            }
        }
    }
}
