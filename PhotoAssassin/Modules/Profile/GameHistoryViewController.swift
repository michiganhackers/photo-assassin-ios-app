//
//  GameHistoryViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 8/3/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import Firebase
import UIKit

class GameHistoryViewController: NavigatingViewController {
    // MARK: - Class constants
    static let topMargin: CGFloat = 20.0

    // MARK: - Private members
    private let backend = BackendCaller()

    // MARK: - Public members
    let player: Player
    lazy var gameList = GameList<GameHistoryCell> { gameStats, _ in
        let database = Firestore.firestore()
        let focused = LobbyInfo.PlayerWithStatus(
            player: self.player,
            relationship: .neutral,
            stats: gameStats
        )
        let gameDoc = database.collection("games").document(gameStats.game.id)
        gameDoc.getDocument { game, error in
            if let error = error {
                print("Error retrieving game: \(error)")
                return
            }
            guard let game = game else {
                print("Could not retrieve game")
                return
            }
            gameDoc.collection("players").getDocuments { players, error in
                if let error = error {
                    print("Error retrieving players: \(error)")
                    return
                }
                guard let players = players else {
                    print("Could not retrieve players")
                    return
                }
                var otherPlayers: [LobbyInfo.PlayerWithStatus] = []
                for playerDoc in players.documents {
                    if playerDoc.documentID == self.player.uid {
                        continue
                    }
                    self.backend.player(fromUID: playerDoc.documentID) { player in
                        let stats = GameStats(
                            game: gameStats.game,
                            kills: playerDoc.get("kills") as? Int ?? -1,
                            place: playerDoc.get("place") as? Int ?? -1,
                            didGameEnd: true
                        )
                        // TODO: Handle case when player == nil better.
                        otherPlayers.append(LobbyInfo.PlayerWithStatus(
                            player: player ?? self.player,
                            relationship: .neutral,
                            stats: stats
                        ))
                        if otherPlayers.count == players.documents.count - 1 {
                            let start = game.get("startTime") as? Timestamp ?? Timestamp()
                            let end = game.get("endTime") as? Timestamp ?? Timestamp()
                            self.push(navigationScreen: .lobbyInfo(LobbyInfo(
                                gameLobby: gameStats.game,
                                focusedPlayer: focused,
                                myselfPermission: .viewer,
                                otherPlayers: otherPlayers,
                                startDate: start.dateValue(),
                                endDate: end.dateValue()
                            )))
                        }
                    }
                }
            }
        }
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
        self.player = Player(uid: "", username: "", relationship: .none)
        super.init(coder: aDecoder)
    }

    init(player: Player) {
        self.player = player
        super.init(title: "Game History")
        self.player.loadGameHistory { gameHistory in
            self.gameList.games = gameHistory
            self.gameList.tableView.reloadData()
        }
    }
}
