//
//  MenuNavigationTitle.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/5/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class MenuNavigationTitle: UILabel {
    static let fontSize: CGFloat = 45.0
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(_ title: String) {
        super.init(frame: .zero)
        attributedText = NSAttributedString(string: title,
            attributes: [
                .font: R.font.economicaBold.orDefault(
                    size: MenuNavigationTitle.fontSize, style: .headline),
                .foregroundColor: UIColor.white
            ]
        )
    }
}
