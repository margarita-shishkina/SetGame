//
//  Array+Rand.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 30/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation

extension Array {
    mutating func removeRand() -> Element {
        return remove(at: count.rand)
    }
}
