//
//  ChangeFriendStatusAccessory.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 7/27/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class ChangeFriendStatusAccessory: UIButton {
    // MARK: - Public member variables
    let titleAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Colors.text,
        .font: R.font.economicaBold.orDefault(size: 24.0)
    ]
    // MARK: - Private member variables
    private let player: Player

    // MARK: - Event handlers
    @objc
    func performAction() {
        var titleText = ""
        if player.relationship == .friend {
            player.relationship = .none
            titleText = "Add"
            // changes the icon back to add friend
            self.setImage(R.image.addFriend()?.withRenderingMode(.alwaysTemplate), for: .normal)
            print("TODO: Update friend status in Firebase as not a friend")
        } else if player.relationship == .none {
            player.relationship = .friend
            titleText = "Remove"
            // changes the icon to remove friend
            self.setImage(R.image.removeFriend()?.withRenderingMode(.alwaysTemplate), for: .normal)
            print("TODO: Update friend status in Firebase as a friend")
        }
        self.tintColor = Colors.text
        self.setAttributedTitle(
            NSAttributedString(string: titleText, attributes: titleAttributes),
            for: .normal
        )

        self.addTarget(self, action: #selector(performAction), for: .touchUpInside)
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        self.player = Player.myself
        super.init(coder: aDecoder)
    }
    init(player: Player) {
        self.player = player
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 30.0))

        var titleText = ""
        if player.relationship == .friend {
            titleText = "Remove"
            self.setImage(R.image.removeFriend()?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else if player.relationship == .none {
            titleText = "Add"
            self.setImage(R.image.addFriend()?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        self.tintColor = Colors.text
        self.setAttributedTitle(
            NSAttributedString(string: titleText, attributes: titleAttributes),
            for: .normal
        )

        self.addTarget(self, action: #selector(performAction), for: .touchUpInside)
    }
}
