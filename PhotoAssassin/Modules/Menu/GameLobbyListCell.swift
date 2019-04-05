//
//  GameLobbyListCell.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 3/27/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class GameLobbyListCell: UITableViewCell {
    static let textSize: CGFloat = 18.0
    static let cellReuseIdentifer = "gameLobbyCell"
    let edgeCurve: CGFloat = 12.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(lobby: GameLobby) {
        super.init(style: .subtitle, reuseIdentifier: GameLobbyListCell.cellReuseIdentifer)

        textLabel?.text = lobby.title
        textLabel?.textColor = Colors.text
        textLabel?.font = R.font.economicaBold(size: GameLobbyListCell.textSize)
        detailTextLabel?.text = lobby.description
        detailTextLabel?.textColor = Colors.text
        detailTextLabel?.font = R.font.economicaRegular(size: GameLobbyListCell.textSize)

        backgroundView = nil
        backgroundColor = Colors.subsectionBackground
        layer.cornerRadius = edgeCurve
    }
    static func getHeight() -> CGFloat {
        return textSize * 3
    }
}
