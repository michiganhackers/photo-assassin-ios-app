//
//  LoginTextField.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 2/22/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {
    let cornerRadius: CGFloat = 15.0
    let height: CGFloat = 67.0
    let textInsetX: CGFloat = 15.0
    let textSize: CGFloat = 36.0

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textInsetX, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textInsetX, dy: 0)
    }

    convenience init(_ textContent: String, isSecure: Bool, isEmail: Bool) {
        self.init()
        heightAnchor.constraint(equalToConstant: height).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = cornerRadius
        backgroundColor = Colors.seeThroughContrast
        textColor = Colors.text

        if isEmail {
            autocapitalizationType = .none
            keyboardType = .emailAddress
        }
        isSecureTextEntry = isSecure
        let inputFont = R.font.economicaBold(size: textSize)
        font = inputFont

        if let font = inputFont {
            attributedPlaceholder = NSAttributedString(string: textContent,
                attributes: [
                    .foregroundColor: Colors.seeThroughText,
                    .font: font
                ]
            )
        }
    }
}
