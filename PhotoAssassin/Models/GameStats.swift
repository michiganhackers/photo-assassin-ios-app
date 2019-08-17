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
    var didStartGame: Bool {
        return kills != nil
    }
    var gameTitle: String {
        return game.title
    }

    let game: GameLobby
    let kills: Int?
    let place: Int?

    // NOTE: If place == nil, then the Player is still playing in the game (i.e.
    //  they are still alive and the game has not yet ended). If kills == nil,
    //  then the Player has not yet started the game.
    init(game: GameLobby, kills: Int? = nil, place: Int? = nil) {
        // ASSERTION: The player must not be finished with the game if they have
        //  not yet started it.
        assert(place == nil || kills != nil)
        self.game = game
        self.kills = kills
        self.place = place
    }
}
