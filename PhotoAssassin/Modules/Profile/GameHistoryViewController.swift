//
//  GameHistoryViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 8/3/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class GameHistoryViewController: NavigatingViewController {
    // MARK: - Class constants
    static let topMargin: CGFloat = 20.0

    // MARK: - Public members
    let player: Player
    lazy var gameList = GameList<GameHistoryCell> { gameStats, _ in
        // TODO: Get info from Firebase
        let info = LobbyInfo(
            gameLobby: gameStats.game,
            focusedPlayer: LobbyInfo.PlayerWithStatus(
                player: self.player,
                relationship: .neutral,
                stats: gameStats
            ),
            myselfPermission: .viewer,
            otherPlayers: [
                LobbyInfo.PlayerWithStatus(
                    player: Player(username: "Bendudeman", relationship: .none),
                    relationship: .neutral,
                    stats: GameStats(game: gameStats.game, kills: 3, place: 3)
                ),
                LobbyInfo.PlayerWithStatus(
                    player: Player(username: "Owain", relationship: .none),
                    relationship: .neutral,
                    stats: GameStats(game: gameStats.game, kills: 5, place: 2)
                ),
                LobbyInfo.PlayerWithStatus(
                    player: Player(username: "Vincent", relationship: .none),
                    relationship: .neutral,
                    stats: GameStats(game: gameStats.game, kills: 0, place: 4)
                )
            ],
            startDate: Date(timeIntervalSince1970: 0.0),
            endDate: Date(timeIntervalSinceNow: 1.0)
        )
        self.push(navigationScreen: .lobbyInfo(info))
    }

    // MARK: - Custom methods
    func addSubviews() {
        view.addSubview(gameList.view)
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        gameList.view.topAnchor.constraint(equalTo: margins.topAnchor,
                                           constant: type(of: self).topMargin).isActive = true
        gameList.view.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        gameList.view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        gameList.view.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
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
        self.player = Player.myself
        super.init(coder: aDecoder)
    }

    init(player: Player) {
        self.player = player
        super.init(title: "Game History")
        self.player.loadGameHistory { gameHistory in
            gameList.games = gameHistory
            gameList.tableView.reloadData()
        }
    }
}
