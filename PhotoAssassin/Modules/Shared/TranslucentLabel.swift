//
//  TranslucentLabel.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 6/29/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class TranslucentLabel: UILabel {
    let size: CGFloat
    required init?(coder aDecoder: NSCoder) {
        self.size = 0
        super.init(coder: aDecoder)
    }
    init(text: String, size: CGFloat) {
        self.size = size
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        attributedText = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: Colors.seeThroughText,
                .font: R.font.economicaBold.orDefault(size: size)
            ]
        )
    }
    func setText(text: String) {
        attributedText = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: Colors.seeThroughText,
                .font: R.font.economicaBold.orDefault(size: size)
            ]
        )
    }
}
