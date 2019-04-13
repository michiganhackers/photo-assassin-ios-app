//
//  PlayerListCell.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class PlayerListCell: UITableViewCell {
    static let maxAccessoryWidth: CGFloat = 100.0
    static let textSize: CGFloat = 36.0
    static func getHeight() -> CGFloat {
        return textSize * 1.4
    }

    private func addStyling() {
        textLabel?.textColor = Colors.seeThroughText
        textLabel?.font = R.font.economicaBold(size: PlayerListCell.textSize)

        backgroundView = nil
        backgroundColor = nil
        selectionStyle = .none
        tintColor = Colors.text
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addStyling()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addStyling()
    }
}
