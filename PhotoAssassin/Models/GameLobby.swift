//
//  GameLobby.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 3/28/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//
// This file provides a model for game lobbies. Each GameLobby contains
// the information that is available about a game before a player joins it.

import Foundation

class GameLobby {
    let id: String
    let title: String
    let numberInLobby: Int
    let numberAlive: Int?

    // Note: If numberAlive is nil, the game has not yet started or has ended.
    //  Otherwise, it is in progress.
    init(id: String, title: String, numberInLobby: Int, numberAlive: Int? = nil) {
        self.id = id
        self.title = title
        self.numberInLobby = numberInLobby
        self.numberAlive = numberAlive
    }
}
