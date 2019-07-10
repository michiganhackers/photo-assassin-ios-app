//
//  SettingsCell.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 6/22/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    static let horizontalMargin: CGFloat = 15.0
    static let textSize: CGFloat = 36.0
    static let cellReuseIdentifer = "settingsCell"
    static let imageWidth: CGFloat = 45.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(label: String, image: UIImage?) {
        super.init(style: .default, reuseIdentifier: SettingsCell.cellReuseIdentifer)
        textLabel?.text = label
        textLabel?.textColor = Colors.text
        textLabel?.textAlignment = .left
        textLabel?.font = R.font.economicaBold(size: SettingsCell.textSize)

        imageView?.image = image

        accessoryType = .disclosureIndicator

        backgroundView = nil
        backgroundColor = nil
        selectionStyle = .none
    }

    static func getHeight() -> CGFloat {
        return textSize * 1.7
    }
}
