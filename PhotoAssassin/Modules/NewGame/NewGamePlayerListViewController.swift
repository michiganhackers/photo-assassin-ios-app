//
//  NewGamePlayerListViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class NewGamePlayerListViewController: PlayerListViewController {
    // MARK: - Class members
    private let players: [(Player, Player.InvitationStatus)]

    // MARK: - Overrides
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayerListCell = super.tableView(tableView, cellForRowAt: indexPath)
        var text: String
        var color: UIColor
        switch players[indexPath.row].1 {
        case .invited, .notInvited:
            text = "?"
            color = Colors.unknown
        case .notPlaying:
            text = "X"
            color = Colors.failure
        case .playing:
            text = "!"
            color = Colors.success
        }
        if !(cell.accessoryView is UILabel) {
            let rightTextLabel = UILabel(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: PlayerListCell.maxAccessoryWidth,
                    height: PlayerListCell.textSize
                )
            )
            rightTextLabel.textColor = Colors.seeThroughText
            rightTextLabel.font = R.font.economicaBold(size: PlayerListCell.textSize)
            rightTextLabel.textAlignment = .right
            rightTextLabel.text = text
            rightTextLabel.textColor = color
            cell.accessoryView = rightTextLabel
        }
        return cell
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        self.players = []
        super.init(coder: aDecoder)
    }
    init(players list: [(Player, Player.InvitationStatus)]) {
        self.players = list
        super.init(players: list.map { $0.0 }, hasGradientBackground: true)
    }
}
