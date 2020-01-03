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
        self.backend.lobbyInfo(for: gameStats.game, focused: self.player) { lobbyInfo in
            guard let lobbyInfo = lobbyInfo else {
                return
            }
            self.push(navigationScreen: .lobbyInfo(lobbyInfo))
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
        self.player = Player(uid: "", username: "", relationship: .none, profilePicture: "")
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
