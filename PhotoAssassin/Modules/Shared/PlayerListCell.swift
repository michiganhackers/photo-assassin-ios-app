//
//  PlayerListCell.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class PlayerListCell: UITableViewCell {
    static let textSize: CGFloat = 36.0
    static let maxWidth: CGFloat = 50.0
    static func getHeight() -> CGFloat {
        return textSize * 1.25
    }
    let rightTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: PlayerListCell.maxWidth, height: textSize))

    private func addStyling() {
        textLabel?.textColor = Colors.seeThroughText
        textLabel?.font = R.font.economicaBold(size: PlayerListCell.textSize)
        rightTextLabel.textColor = Colors.seeThroughText
        rightTextLabel.font = R.font.economicaBold(size: PlayerListCell.textSize)
        rightTextLabel.textAlignment = .right
        accessoryView = rightTextLabel

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
