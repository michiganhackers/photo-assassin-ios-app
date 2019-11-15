//
//  Player.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import FirebaseStorage
import FirebaseUI
import UIKit

class Player {
    // MARK: - Nested types
    enum InvitationStatus {
        case invited
        case notInvited
    }
    enum Relationship {
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
        relationship: .myself,
        profilePicture: "https://firebasestorage.googleapis.com/v0/b/photo-assassin.appspot.com" +
            "/o/images%2Fprofile_pictures%2F5QC6Wt8bIiXBSWHmBAMm1JwdN6l2" +
            "?alt=media&token=57a23100-abad-429d-8ce2-60cf7368dd19",
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

    func loadFriends(completionHandler: ([Player]) -> Void) {
        // TODO: Grab friends from Firebase based on username
        let friends = [
            Player(username: "dummy_friend_1", relationship: .friend, profilePicture: "TODO"),
            Player(username: "dummy_2_me", relationship: .myself, profilePicture: "TODO"),
            Player(username: "dummy_3...", relationship: .none, profilePicture: "TODO")
        ]
        self.friends = friends
        completionHandler(friends)
    }

    func loadGameHistory(completionHandler: ([GameStats]) -> Void) {
        // TODO: Grab game history from Firebase based on username
        let games = [
            GameStats(game: GameLobby(id: "0ab", title: "Snipefest", numberInLobby: 0, maxPlayers: 0),
                      kills: 5, place: 2, didGameEnd: true),
            GameStats(game: GameLobby(id: "1cd", title: "Mhackers xD lolz", numberInLobby: 0, maxPlayers: 0),
                      kills: 15, place: 1, didGameEnd: true),
            GameStats(game: GameLobby(id: "2ef", title: "Bonfire Party", numberInLobby: 0, maxPlayers: 0),
                      kills: 21, place: 7, didGameEnd: true)
        ]
        self.gameHistory = games
        completionHandler(games)
    }

    // MARK: - Public members
    var username: String
    var relationship: Relationship
    var profilePicture: String
    var stats: Player.Stats?
    var friends: [Player]?
    var gameHistory: [GameStats]?

    // MARK: - Initializers
    // NOTE: Be careful to avoid reference loops with the array of friends.
    init(username: String,
         relationship: Relationship,
         profilePicture: String,
         stats: Stats? = nil
    ) {
        self.username = username
        self.relationship = relationship
        self.profilePicture = profilePicture
        self.stats = stats
    }
}
