//
//  LobbyInfo.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 8/4/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import Foundation

class LobbyInfo {
    // MARK: - Nested types
    enum GameRelationship {
        case dead
        case neutral
        case target
    }
    struct PlayerWithStatus {
        let player: Player
        let relationship: GameRelationship
        let stats: GameStats
    }
    enum PlayerPermissionLevel {
        case owner
        case participant
        case viewer
    }

    // MARK: - Public members
    let gameLobby: GameLobby
    let focusedPlayer: PlayerWithStatus?
    let myselfPermission: PlayerPermissionLevel
    let otherPlayers: [PlayerWithStatus]
    let startDate: Date?
    let endDate: Date?

    // MARK: - Public methods and computed properties
    var canJoin: Bool {
        return !isStarted && myselfPermission == .viewer
    }
    var canInvite: Bool {
        return !isStarted && myselfPermission != .viewer
    }
    var canLeave: Bool {
        return !isStarted && myselfPermission == .participant
    }
    var canStart: Bool {
        return !isStarted && myselfPermission == .owner
    }
    var isStarted: Bool {
        return startDate != nil
    }
    var isEnded: Bool {
        return endDate != nil
    }
    var allPlayers: [PlayerWithStatus] {
        if let focused = focusedPlayer {
            return [focused] + otherPlayers
        }
        return otherPlayers
    }

    // MARK: - Initializers
    init(gameLobby: GameLobby,
         focusedPlayer: PlayerWithStatus?,
         myselfPermission: PlayerPermissionLevel,
         otherPlayers: [PlayerWithStatus],
         startDate: Date? = nil,
         endDate: Date? = nil) {
        // ASSERTION: If there is an end date, there must be a start date.
        assert(endDate == nil || startDate != nil)
        self.gameLobby = gameLobby
        self.focusedPlayer = focusedPlayer
        self.myselfPermission = myselfPermission
        self.otherPlayers = otherPlayers.sorted { player1, player2 in
            if player1.relationship == .dead && player2.relationship == .dead {
                guard let place1 = player1.stats.place, let place2 = player2.stats.place else {
                    return player1.player.username > player2.player.username
                }
                return place1 < place2
            }
            if player1.relationship == .dead {
                return true
            }
            if player2.relationship == .dead {
                return false
            }

            if player1.relationship == .target && player2.relationship == .target {
                return player1.player.username > player2.player.username
            }
            if player1.relationship == .target {
                return false
            }
            if player2.relationship == .target {
                return true
            }

            guard let kills1 = player1.stats.kills, let kills2 = player2.stats.kills else {
                return player1.player.username > player2.player.username
            }
            if kills1 == kills2 {
                return player1.player.username > player2.player.username
            }
            return kills1 > kills2
        }
        self.startDate = startDate
        self.endDate = endDate
    }
}
