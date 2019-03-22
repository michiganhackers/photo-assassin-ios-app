//
//  SocialMediaSignIn.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 2/28/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class SocialMediaSignIn: UIButton {
    let borderWidth: CGFloat = 4.0
    let cornerRadius: CGFloat = 15.0
    let textSize: CGFloat = 30.0
    let height: CGFloat = 50.0
    convenience init(_ label: String, icon: UIImage?) {
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
        setImage(icon, for: .normal)
        semanticContentAttribute = .forceLeftToRight
    }
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let defaultImageRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - defaultImageRect.width
        return defaultImageRect.offsetBy(dx: -50, dy: 0)///(availableWidth / 2), dy: 0)
    }
}
