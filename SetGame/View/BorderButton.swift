//
//  BorderButton.swift
//  SetGame
//
//  Created by Margarita Sergeevna on 05/09/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import UIKit

@IBDesignable class BorderButton: UIButton {
    @IBInspectable var borderWidth: CGFloat = 3.0 { didSet { setup() } }
    @IBInspectable var borderColor: UIColor = .clear { didSet { setup() } }
    @IBInspectable var cornerRadius: CGFloat = 8.0 { didSet { setup() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
    }
}
