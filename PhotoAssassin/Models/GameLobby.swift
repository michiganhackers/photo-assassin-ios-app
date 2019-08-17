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
    let capacity: Int

    init(id: String, title: String, numberInLobby: Int, capacity: Int) {
        self.id = id
        self.title = title
        self.numberInLobby = numberInLobby
        self.capacity = capacity
    }
}
