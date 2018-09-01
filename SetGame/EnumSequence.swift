//
//  EnumSequence.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 30/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation

protocol EnumSequence {
    associatedtype T: RawRepresentable where T.RawValue == Int
    static func all() -> AnySequence<T>
}

extension EnumSequence {
    static func all() -> AnySequence<T> {
        return AnySequence { return EnumIterator() }
    }
}

struct EnumIterator<T: RawRepresentable>: IteratorProtocol where T.RawValue == Int {
    var index = 0
    
    mutating func next() -> T? {
        guard let item = T(rawValue: index) else { return nil }
        index += 1
        return item
    }
}
