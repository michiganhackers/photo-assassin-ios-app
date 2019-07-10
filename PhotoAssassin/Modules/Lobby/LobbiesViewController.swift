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
    let gameLobbyList = GameLobbyList()

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
