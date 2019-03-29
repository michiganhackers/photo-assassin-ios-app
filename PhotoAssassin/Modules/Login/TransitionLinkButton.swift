//
//  TransitionLinkButton.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 3/17/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//
//  A TransitionLinkButton is an underlined, non-bordered button styled in
//  maroon.

import UIKit

class TransitionLinkButton: UIButton {
    let textSize: CGFloat = 25.0

    convenience init(_ title: String) {
        self.init(frame: .zero)
        setTitleColor(Colors.burgundy, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = R.font.economicaBold(size: textSize)
        let buttonText = NSMutableAttributedString(string: title)
        buttonText.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: buttonText.string.count)
        )
        buttonText.addAttribute(
            .foregroundColor,
            value: Colors.seeThroughContrast,
            range: NSRange(location: 0, length: buttonText.string.count)
        )
        setAttributedTitle(buttonText, for: .normal)
    }
}
