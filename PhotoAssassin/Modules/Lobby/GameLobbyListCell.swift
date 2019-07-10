//
//  GameLobbyListCell.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 3/27/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class GameLobbyListCell: UITableViewCell {
    static let horizontalMargin: CGFloat = 15.0
    static let textSize: CGFloat = 36.0
    static let cellReuseIdentifer = "gameLobbyCell"
    let edgeCurve: CGFloat = 12.0

    let playerCountLabel = UILabel(frame: .zero)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(lobby: GameLobby) {
        super.init(style: .default, reuseIdentifier: GameLobbyListCell.cellReuseIdentifer)
        textLabel?.text = lobby.title
        textLabel?.textColor = Colors.text
        textLabel?.textAlignment = .left
        textLabel?.font = R.font.economicaBold(size: GameLobbyListCell.textSize)

        contentView.addSubview(playerCountLabel)
        playerCountLabel.textAlignment = .right
        playerCountLabel.text = "\(lobby.numberInLobby)/\(lobby.capacity)"
        playerCountLabel.textColor = Colors.text
        playerCountLabel.font = R.font.economicaBold(size: GameLobbyListCell.textSize)

        backgroundView = nil
        backgroundColor = Colors.subsectionBackground
        selectionStyle = .none
        layer.cornerRadius = edgeCurve
        addConstraints()
    }

    func addConstraints() {
        if let titleLabel = textLabel {
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                constant: GameLobbyListCell.horizontalMargin).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            playerCountLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                constant: -GameLobbyListCell.horizontalMargin).isActive = true
            playerCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            playerCountLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    static func getHeight() -> CGFloat {
        return textSize * 1.7
    }
}
