//
//  InvitePlayerListViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/13/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class InvitePlayerListViewController: PlayerListViewController {
    // MARK: - Class members
    private let players: [(Player, Player.InvitationStatus)]

    // MARK: - Overrides
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayerListCell = super.tableView(tableView, cellForRowAt: indexPath)
        let accessoryFrame = CGRect(
            x: 0,
            y: 0,
            width: PlayerListCell.maxAccessoryWidth,
            height: PlayerListCell.textSize * 1.15
        )
        switch players[indexPath.row].1 {
        case .notInvited:
            if let button = cell.accessoryView as? InviteAccessoryButton {
                button.indexPath = indexPath
            } else {
                // If the player is not invited, add an invite button
                let button = InviteAccessoryButton(frame: accessoryFrame)
                button.addTarget(self, action: #selector(inviteButtonTapped), for: .touchUpInside)
                button.indexPath = indexPath
                cell.accessoryView = button
            }
        default:
            if !(cell.accessoryView is UILabel) {
                let label = UILabel(frame: accessoryFrame)
                label.attributedText = NSAttributedString(
                    string: "invited",
                    attributes: [
                        .font: R.font.economicaBold.orDefault(size: PlayerListCell.textSize),
                        .foregroundColor: Colors.seeThroughText
                    ]
                )
                label.textAlignment = .right
                cell.accessoryView = label
            }
        }
        return cell
    }

    // MARK: - Event listeners
    @objc
    func inviteButtonTapped(_ sender: InviteAccessoryButton) {
        if let path = sender.indexPath {
            let player = players[path.row].0
            print("TODO: Invite person with username \(player.username)")
        }
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        self.players = []
        super.init(coder: aDecoder)
    }
    init(players list: [(Player, Player.InvitationStatus)]) {
        self.players = list
        super.init(players: list.map { $0.0 }, hasGradientBackground: false)
    }
}
