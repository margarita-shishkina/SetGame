//
//  Int+Rand.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 30/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation

extension Int {
    var rand: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}
