//
//  GameStats.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 8/4/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//
//  An instance of this class represents the status/statistics of a single Player
//  within a single game. The game may be complete, in progress, or not started.
//  The Player may be eliminated or alive.

import Foundation

class GameStats {
    var didWin: Bool {
        return place == 1
    }
    var isDoneWithGame: Bool {
        return place != nil
    }
    let gameID: String
    let gameTitle: String
    let kills: Int
    let place: Int?

    // NOTE: If place == nil, then the Player is still playing in the game (i.e.
    //  they are still alive and the game has not yet ended).
    init(gameID: String, gameTitle: String, kills: Int, place: Int? = nil) {
        self.gameID = gameID
        self.gameTitle = gameTitle
        self.kills = kills
        self.place = place
    }
}
