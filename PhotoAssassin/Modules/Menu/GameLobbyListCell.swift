//
//  GameLobbyListCell.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 3/27/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class GameLobbyListCell: UITableViewCell {
    static let titleTextSize: CGFloat = 30.0
    static let detailTextSize: CGFloat = 18.0
    static let cellReuseIdentifer = "gameLobbyCell"
    let edgeCurve: CGFloat = 12.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(lobby: GameLobby) {
        super.init(style: .subtitle, reuseIdentifier: GameLobbyListCell.cellReuseIdentifer)
        // translatesAutoresizingMaskIntoConstraints = false
        textLabel?.text = lobby.title
        textLabel?.textColor = Colors.text
        textLabel?.textAlignment = .center
        textLabel?.font = R.font.economicaBold(size: GameLobbyListCell.titleTextSize)
        detailTextLabel?.text = "Number of alive users: \(lobby.numberInLobby)"
        detailTextLabel?.textColor = Colors.text
        detailTextLabel?.font = R.font.economicaRegular(size: GameLobbyListCell.detailTextSize)

        backgroundView = nil
        backgroundColor = Colors.subsectionBackground
        selectionStyle = .none
        layer.cornerRadius = edgeCurve
        addConstraints()
    }
    func addConstraints() {
        if let titleLabel = textLabel {
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    static func getHeight() -> CGFloat {
        return (detailTextSize + titleTextSize) * 1.5
    }
}
