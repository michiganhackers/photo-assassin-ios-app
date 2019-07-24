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
    let leftImageMargin: CGFloat = 10.0

    //  This override is needed to align the social media logo to the left side
    //  of the button. Normally, the button looks like this:
    //    ___________________________
    //   |        _____              |
    //   |       |Image| Title       |   (with the title and image centered)
    //   |       |_____|             |
    //   |___________________________|
    //  We can calculate the amount of "remaining width" - i.e. the width of the
    //  button unused by the image, the label, and inset margins.
    //  We can then move the image to the left by remainingWidth / 2. This left-
    //  aligns the image, and although the label is no longer centered in the
    //  entire container, it still is centered in the space between the image
    //  and the right edge of the button:
    //    ___________________________
    //   | _____                     |
    //   ||Image|       Title        |
    //   ||_____|                    |
    //   |___________________________|
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageRect = super.imageRect(forContentRect: contentRect)
        let titleRect = super.titleRect(forContentRect: contentRect)
        let insetsWidth = imageEdgeInsets.left + imageEdgeInsets.right +
                          titleEdgeInsets.left + titleEdgeInsets.right
        let contentWidth = imageRect.width + titleRect.width
        let remainingWidth = contentRect.width - insetsWidth - contentWidth
        return imageRect.offsetBy(dx: -remainingWidth / 2.0, dy: 0.0)
    }

    convenience init(_ label: String, height: CGFloat, textSize: CGFloat, image: UIImage) {
        self.init()
        setTitle(label, for: .normal)
        setTitleColor(Colors.seeThroughText, for: .normal)
        setTitleColor(Colors.seeThroughContrast, for: .disabled)
        setTitleColor(Colors.seeThroughContrast, for: .focused)
        setTitleColor(Colors.seeThroughContrast, for: .highlighted)
        setTitleColor(Colors.seeThroughContrast, for: .selected)

        setImage(image, for: .normal)

        layer.borderColor = Colors.seeThroughContrast.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius

        imageEdgeInsets.left = leftImageMargin

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true

        titleLabel?.font = R.font.economicaBold(size: textSize)
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
}
