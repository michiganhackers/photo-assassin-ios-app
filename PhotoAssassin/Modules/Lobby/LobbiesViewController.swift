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
    let backgroundGradient = BackgroundGradient()
    private let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    // MARK: - UI elements
    var gameLobbyList = GameLobbyList(isDetailed: false)

    // MARK: - Custom functions
    func addSubviews() {
        backgroundGradient.addToView(view)
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
        navigationItem.titleView = MenuNavigationTitle(title ?? "")
        backButton.tintColor = .white
        navigationItem.backBarButtonItem = backButton
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundGradient.layoutInView(view)
        setUpConstraints()
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(isDetailed: Bool) {
        gameLobbyList = GameLobbyList(isDetailed: isDetailed)
        if isDetailed {
            super.init(title: "Choose Game(s)")
            self.title = "Choose Game(s)"
        } else {
            super.init(title: "Lobbies")
            self.title = "Lobbies"
        }
    }
}
