//
//  PickerViewCell.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/6/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class PickerViewCell: UITableViewCell {
    static let textSize: CGFloat = 33.0
    static func getHeight() -> CGFloat {
        return textSize * 1.5
    }

    private func addStyling() {
        textLabel?.textColor = Colors.text
        textLabel?.font = R.font.economicaBold(size: PickerViewCell.textSize)

        backgroundView = nil
        backgroundColor = nil
        selectionStyle = .none
        tintColor = Colors.text
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addStyling()
    }
}
