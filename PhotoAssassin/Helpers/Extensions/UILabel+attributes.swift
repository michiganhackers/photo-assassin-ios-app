//
//  UILabel+attributes.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/12/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(
        _ text: String,
        attributes: [NSAttributedString.Key: Any],
        align: NSTextAlignment = .left
    ) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.attributedText = NSAttributedString(
            string: text,
            attributes: attributes
        )
        self.textAlignment = align
    }
}
