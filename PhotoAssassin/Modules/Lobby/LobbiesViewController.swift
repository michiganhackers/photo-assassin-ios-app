//
//  ActiveGamesViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 4/4/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class LobbiesViewController: NavigatingViewController {
    // MARK: - Class Constants
    let topMargin: CGFloat = 40.0
    let middleMargin: CGFloat = 10.0
    let backgroundGradient = BackgroundGradient()
    private let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    var detail = false
    
    lazy var submitButton: UIButton = {
        let gameButton = TranslucentButton("Submit")
        gameButton.addTarget(self, action: #selector(toSubmit), for: .touchUpInside)
        return gameButton
    }()
    
    // MARK: - UI Elements
    var gameLobbyList = GameLobbyList(isDetailed: false)

    // MARK: - Custom functions
    func addSubviews() {
        backgroundGradient.addToView(view)
        view.addSubview(gameLobbyList.view)
        view.addSubview(submitButton)
    }
    
    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        gameLobbyList.view.topAnchor.constraint(equalTo: margins.topAnchor,
                                                constant: topMargin).isActive = true
        gameLobbyList.view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        gameLobbyList.view.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        submitButton.topAnchor.constraint(equalTo: gameLobbyList.view.bottomAnchor, constant: middleMargin).isActive = true
        submitButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        submitButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -middleMargin).isActive = true
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        //super.viewDidLoad()
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
    
    // MARK: - Action Listeners
    @objc func toSubmit() {
        // TODO: Submit Photo
        print("Submit button pressed")
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    init(isDetailed: Bool) {
        gameLobbyList = GameLobbyList(isDetailed: isDetailed)
        detail = isDetailed
        if detail {
            super.init(title: "Choose Game(s)")
            self.title = "Choose Game(s)"
        } else {
            super.init(title: "Lobbies")
            self.title = "Lobbies"
        }
        
    }
}
