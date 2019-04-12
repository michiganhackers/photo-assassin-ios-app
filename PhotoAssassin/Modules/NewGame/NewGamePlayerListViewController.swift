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
        case .invited:
            text = "?"
            color = Colors.unknown
        case .notPlaying:
            text = "X"
            color = Colors.failure
        case .playing:
            text = "!"
            color = Colors.success
        }
        cell.rightTextLabel.text = text
        cell.rightTextLabel.textColor = color
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
