//
//  GameHistoryCell.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 8/3/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class GameHistoryCell: UITableViewCell, GameDataCell {
    typealias GameDataType = Player.GameStats

    static let horizontalMargin: CGFloat = 15.0
    static let textSize: CGFloat = 36.0
    static let cellReuseIdentifer = "gameHistoryCell"
    let edgeCurve: CGFloat = 12.0

    let killCountLabel = UILabel(frame: .zero)
    let crownImage = UIImageView(frame: .zero)
    let hasCrown: Bool

    var cell: UITableViewCell {
        return self
    }

    required init?(coder aDecoder: NSCoder) {
        self.hasCrown = false
        super.init(coder: aDecoder)
    }
    required init(gameData: Player.GameStats) {
        self.hasCrown = gameData.didWin
        super.init(style: .default, reuseIdentifier: GameHistoryCell.cellReuseIdentifer)
        textLabel?.text = gameData.name
        textLabel?.textColor = Colors.text
        textLabel?.textAlignment = .left
        textLabel?.font = R.font.economicaBold(size: GameHistoryCell.textSize)

        contentView.addSubview(killCountLabel)
        killCountLabel.textAlignment = .right
        killCountLabel.text = "\(gameData.kills)"
        killCountLabel.textColor = Colors.text
        killCountLabel.font = R.font.economicaBold(size: GameHistoryCell.textSize)
        if hasCrown {
            contentView.addSubview(crownImage)
            crownImage.image = R.image.crown()?.withRenderingMode(.alwaysTemplate)
            crownImage.tintColor = Colors.crown
        }

        backgroundView = nil
        backgroundColor = Colors.subsectionBackground
        selectionStyle = .none
        layer.cornerRadius = edgeCurve
        addConstraints()
    }

    func addConstraints() {
        if let titleLabel = textLabel {
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                             constant: GameHistoryCell.horizontalMargin).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            killCountLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                    constant: -GameHistoryCell.horizontalMargin).isActive = true
            killCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            killCountLabel.translatesAutoresizingMaskIntoConstraints = false
        }
        if hasCrown {
            crownImage.rightAnchor.constraint(equalTo: killCountLabel.leftAnchor,
                                              constant: -GameHistoryCell.horizontalMargin).isActive = true
            crownImage.heightAnchor.constraint(equalToConstant: GameHistoryCell.getImageHeight()).isActive = true
            crownImage.widthAnchor.constraint(equalTo: crownImage.heightAnchor).isActive = true
            crownImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            crownImage.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    static func getImageHeight() -> CGFloat {
        return getHeight() * 0.5
    }
    static func getHeight() -> CGFloat {
        return textSize * 1.7
    }
}
