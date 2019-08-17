//
//  ActiveGamesViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 4/4/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class LobbiesViewController: NavigatingViewController {
    // MARK: - Class constants
    let topMargin: CGFloat = 40.0

    // MARK: - UI elements
    lazy var gameLobbyList: GameList<GameLobbyListCell> = {
        let list = GameList<GameLobbyListCell> { lobby, _ in
            // TODO: Grab full lobby info from Firebase
            self.push(navigationScreen: .lobbyInfo(
                LobbyInfo(gameLobby: lobby, focusedPlayer: nil, myselfPermission: .viewer, otherPlayers: [
                    LobbyInfo.PlayerWithStatus(
                        player: Player(username: "Bendudeman", relationship: .none),
                        relationship: .neutral,
                        stats: GameStats(game: lobby)
                    ),
                    LobbyInfo.PlayerWithStatus(
                        player: Player(username: "Owain", relationship: .none),
                        relationship: .neutral,
                        stats: GameStats(game: lobby)
                    ),
                    LobbyInfo.PlayerWithStatus(
                        player: Player(username: "Vincent", relationship: .none),
                        relationship: .neutral,
                        stats: GameStats(game: lobby)
                    )
                ])
            ))
        }
        list.games = [
            GameLobby(id: "0ab", title: "Game 1", numberInLobby: 3, capacity: 5),
            GameLobby(id: "1cd", title: "Another Game", numberInLobby: 8, capacity: 20),
            GameLobby(id: "2ef", title: "Game 3", numberInLobby: 4, capacity: 6),
            GameLobby(id: "3gh", title: "Jason's Game", numberInLobby: 6, capacity: 100)
        ]
        return list
    }()

    // MARK: - Custom functions
    func addSubviews() {
        view.addSubview(gameLobbyList.view)
    }
    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        gameLobbyList.view.topAnchor.constraint(equalTo: margins.topAnchor,
                                                constant: topMargin).isActive = true
        gameLobbyList.view.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        gameLobbyList.view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        gameLobbyList.view.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(title: "Lobbies")
    }
}
