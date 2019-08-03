//
//  GameHistoryViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 8/3/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class GameHistoryViewController: NavigatingViewController {
    // MARK: - Public members
    let player: Player
    lazy var gameList = GameList<GameHistoryCell> { gameStats, _ in
        print("Selected game \(gameStats.name)")
    }

    // MARK: - Custom methods
    func addSubviews() {
        view.addSubview(gameList.view)
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        gameList.view.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
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
        }
    }
}
