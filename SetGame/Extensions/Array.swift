//
//  Array+Rand.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 30/08/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func removeRand() -> Element {
        return remove(at: count.rand)
    }
    
    mutating func replace(_ elements: [Element], with newElements: [Element]) {
        guard elements.count == newElements.count else { return }
        for i in 0..<newElements.count {
            if let index = self.index(of: elements[i]) {
                self[index] = newElements[i]
            }
        }
    }
}

extension String {
    func joined(separator: String , count: Int) -> String {
        return [String](repeating: self, count: count).joined(separator: separator)
    }
}
