//
//  InviteAccessoryButton.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/13/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class InviteAccessoryButton: UIButton {
    static let borderWidth: CGFloat = 2.5
    static let cornerRadius: CGFloat = 15.0

    var indexPath: IndexPath?

    // MARK: - Private functions
    private func addStyling() {
        layer.borderColor = Colors.text.cgColor
        layer.borderWidth = InviteAccessoryButton.borderWidth
        layer.cornerRadius = InviteAccessoryButton.cornerRadius
        setAttributedTitle(
            NSAttributedString(
                string: "invite",
                attributes: [
                    .font: R.font.economicaBold.orDefault(size: PlayerListCell.textSize),
                    .foregroundColor: Colors.text
                ]
            ),
            for: .normal
        )
        setAttributedTitle(
            NSAttributedString(
                string: "invite",
                attributes: [
                    .font: R.font.economicaBold.orDefault(size: PlayerListCell.textSize),
                    .foregroundColor: Colors.seeThroughText
                ]
            ),
            for: .highlighted
        )
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addStyling()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addStyling()
    }
}
