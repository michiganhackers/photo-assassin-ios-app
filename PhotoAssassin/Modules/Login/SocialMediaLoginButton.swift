//
//  SocialMediaLoginButton.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 3/14/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class SocialMediaLoginButton: UIButton {
    let borderWidth: CGFloat = 4.0
    let cornerRadius: CGFloat = 15.0
    let textSize: CGFloat = 30.0

    convenience init(_ label: String, height: CGFloat, image: UIImage) {
        self.init()
        setTitle(label, for: .normal)
        setTitleColor(Colors.seeThroughText, for: .normal)
        setTitleColor(Colors.seeThroughText, for: .disabled)
        setTitleColor(Colors.seeThroughText, for: .selected)

        setImage(image, for: .normal)

        layer.borderColor = Colors.seeThroughContrast.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true

        titleLabel?.font = R.font.economicaRegular(size: textSize)
    }
}
