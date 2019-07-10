//
//  TransparentButton.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class TransparentButton: UIButton {
    let cornerRadius: CGFloat = 15.0
    let textSize: CGFloat = 36.0
    let borderWidth: CGFloat = 1.5

    override var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                layer.borderColor = Colors.text.cgColor
            } else {
                layer.borderColor = Colors.seeThroughText.cgColor
            }
        }
    }

    convenience init(_ label: String) {
        self.init()
        setTitle(label, for: .normal)
        setTitleColor(Colors.text, for: .normal)
        setTitleColor(Colors.seeThroughText, for: .disabled)
        setTitleColor(Colors.seeThroughText, for: .focused)
        setTitleColor(Colors.seeThroughText, for: .highlighted)
        setTitleColor(Colors.seeThroughText, for: .selected)
        titleLabel?.font = R.font.economicaBold(size: textSize)
        layer.cornerRadius = cornerRadius
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = Colors.text.cgColor
        layer.borderWidth = borderWidth
    }
}
