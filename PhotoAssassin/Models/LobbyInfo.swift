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
    let focusedPlayer: PlayerWithStatus?
    let myselfPermission: PlayerPermissionLevel
    let otherPlayers: [PlayerWithStatus]
    let startDate: Date?
    let endDate: Date?

    // MARK: - Public methods and computed properties
    var canJoin: Bool {
        return !isStarted && myselfPermission == .viewer
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

    // MARK: - Initializers
    init(focusedPlayer: PlayerWithStatus?,
         myselfPermission: PlayerPermissionLevel,
         otherPlayers: [PlayerWithStatus],
         startDate: Date? = nil,
         endDate: Date? = nil) {
        // ASSERTION: If there is an end date, there must be a start date.
        assert(endDate == nil || startDate != nil)
        self.focusedPlayer = focusedPlayer
        self.myselfPermission = myselfPermission
        self.otherPlayers = otherPlayers.sorted { p1, p2 in
            if p1.relationship == .dead && p2.relationship == .dead {
                guard let place1 = p1.stats.place, let place2 = p2.stats.place else {
                    return p1.player.username < p2.player.username
                }
                return place1 > place2
            }
            if p1.relationship == .dead {
                return true
            }
            if p2.relationship == .dead {
                return false
            }

            if p1.relationship == .target && p2.relationship == .target {
                return p1.player.username < p2.player.username
            }
            if p1.relationship == .target {
                return false
            }
            if p2.relationship == .target {
                return true
            }

            if p1.stats.kills == p2.stats.kills {
                return p1.player.username < p2.player.username
            }
            return p1.stats.kills < p2.stats.kills
        }
        self.startDate = startDate
        self.endDate = endDate
    }
}
