//
//  Player.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import Foundation

class Player {
    // MARK: - Nested types
    enum InvitationStatus {
        case invited
        case notPlaying
        case playing
    }

    // MARK: - Public members
    let username: String
    let name: String
    let isYourFriend: Bool

    // MARK: - Initializers
    init(username: String, name: String, isYourFriend: Bool) {
        self.username = username
        self.name = name
        self.isYourFriend = isYourFriend
    }
}
