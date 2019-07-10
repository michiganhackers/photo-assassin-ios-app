//
//  Player.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class Player {
    // MARK: - Nested types
    enum InvitationStatus {
        case invited
        case notInvited
        case notPlaying
        case playing
    }
    enum Relationship {
        case blocked
        case friend
        case myself
        case none
    }
    struct Stats {
        let deaths: Int
        let gamesWon: Int
        let gamesFinished: Int
        let kills: Int
        let percentile: Double

        var killDeathRatio: Double {
            return Double(kills) / Double(deaths)
        }
        var winPercentage: Double {
            return Double(gamesWon) / Double(gamesFinished)
        }
    }

    // MARK: - Static members
    static var myself = Player(
        username: "hi_there_its_me",
        name: "Me",
        relationship: .myself,
        bio: "Hi. I'm me. I like to play Photo Assassin. This is my profile.",
        stats: Stats(
            deaths: 8,
            gamesWon: 1,
            gamesFinished: 9,
            kills: 19,
            percentile: 0.57
        )
    )

    // MARK: - Public member functions
    func canAddAsFriend() -> Bool {
        return relationship == .none
    }
    func canBlock() -> Bool {
        return relationship != .myself && relationship != .blocked
    }

    // MARK: - Public members
    let username: String
    let name: String
    var profilePicture: UIImage?
    let bio: String
    let relationship: Relationship
    var stats: Stats?

    // MARK: - Initializers
    init(username: String,
         name: String,
         relationship: Relationship,
         bio: String,
         profilePicture: UIImage? = nil,
         stats: Stats? = nil
    ) {
        self.username = username
        self.name = name
        self.relationship = relationship
        self.bio = bio
        self.profilePicture = profilePicture
        self.stats = stats
    }
}
