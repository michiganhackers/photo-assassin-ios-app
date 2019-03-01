//
//  LoginRegisterButton.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 2/23/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class LoginRegisterButton: UIButton {
    let borderWidth: CGFloat = 4.0
    let cornerRadius: CGFloat = 15.0
    let textSize: CGFloat = 30.0

    convenience init(_ label: String, height: CGFloat) {
        self.init()
        setTitle(label, for: .normal)
        setTitleColor(Colors.text, for: .normal)
        setTitleColor(Colors.seeThroughText, for: .disabled)
        setTitleColor(Colors.seeThroughText, for: .selected)

        layer.borderColor = Colors.seeThroughContrast.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true

        titleLabel?.font = R.font.economicaRegular(size: textSize)
    }
}
