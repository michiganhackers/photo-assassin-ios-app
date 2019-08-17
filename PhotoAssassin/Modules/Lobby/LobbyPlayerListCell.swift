//
//  PlayerListCell.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 8/10/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class LobbyPlayerListCell: UITableViewCell, GameDataCell {
    typealias GameDataType = LobbyInfo.PlayerWithStatus

    static let horizontalMargin: CGFloat = 15.0
    static let textSize: CGFloat = 36.0
    static let cellReuseIdentifer = "lobbyPlayerCell"
    let edgeCurve: CGFloat = 12.0

    let killsLabel = UILabel(frame: .zero)
    let gameData: LobbyInfo.PlayerWithStatus?

    var cell: UITableViewCell {
        return self
    }

    required init?(coder aDecoder: NSCoder) {
        self.gameData = nil
        super.init(coder: aDecoder)
    }
    required init(gameData: LobbyInfo.PlayerWithStatus) {
        self.gameData = gameData
        super.init(style: .default, reuseIdentifier: type(of: self).cellReuseIdentifer)
        textLabel?.text = gameData.player.username
        textLabel?.textColor = Colors.text
        textLabel?.textAlignment = .left
        textLabel?.font = R.font.economicaBold(size: type(of: self).textSize)

        if gameData.stats.didStartGame {
            contentView.addSubview(killsLabel)
            killsLabel.textAlignment = .right
            killsLabel.text = "\(gameData.stats.kills ?? 0)"
            killsLabel.textColor = Colors.text
            killsLabel.font = R.font.economicaBold(size: type(of: self).textSize)
        }

        backgroundView = nil
        backgroundColor = Colors.subsectionBackground
        selectionStyle = .none
        layer.cornerRadius = edgeCurve
        addConstraints()
    }

    func addConstraints() {
        if let gameData = self.gameData, let titleLabel = textLabel {
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                             constant: type(of: self).horizontalMargin).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            if gameData.stats.didStartGame {
                killsLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                  constant: -type(of: self).horizontalMargin).isActive = true
                killsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                killsLabel.translatesAutoresizingMaskIntoConstraints = false
            }
        }
    }
    static func getHeight() -> CGFloat {
        return 90.0
    }
    static func getImageHeight() -> CGFloat {
        return getHeight() * 0.8
    }
}
