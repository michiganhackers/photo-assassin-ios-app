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
    let title: String
    let description: String
    let numberInLobby: Int
    let capacity: Int
    let detailed: Bool

    init(title: String, description: String, numberInLobby: Int, capacity: Int, detailed: Bool) {
        self.title = title
        self.description = description
        self.numberInLobby = numberInLobby
        self.capacity = capacity
        self.detailed = detailed
    }
}
