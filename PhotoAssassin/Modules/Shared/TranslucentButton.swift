//
//  TranslucentButton.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/4/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class TranslucentButton: UIButton {
    let cornerRadius: CGFloat = 15.0
    let textSize: CGFloat = 36.0
    convenience init(_ label: String) {
        self.init()
        setTitle(label, for: .normal)
        setTitleColor(Colors.text, for: .normal)
        setTitleColor(Colors.seeThroughContrast, for: .disabled)
        setTitleColor(Colors.seeThroughContrast, for: .focused)
        setTitleColor(Colors.seeThroughContrast, for: .highlighted)
        setTitleColor(Colors.seeThroughContrast, for: .selected)
        titleLabel?.font = R.font.economicaBold(size: textSize)
        layer.cornerRadius = cornerRadius
        backgroundColor = Colors.subsectionBackground

        translatesAutoresizingMaskIntoConstraints = false
    }
}
