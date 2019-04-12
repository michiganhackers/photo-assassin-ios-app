//
//  MenuViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 3/21/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class MenuViewController: NavigatingViewController {
    let gameLobbyHeightRatio: CGFloat = 0.3
    let horizontalButtonSpacing: CGFloat = 12.0
    let navBarSpacing: CGFloat = 20.0
    let verticalButtonSpacing: CGFloat = 18.0

    let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)

    lazy var profileButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: R.image.profileLogo(),
                                   style: .plain,
                                   target: self,
                                   action: #selector(bringToSocial))
        return item
    }()

    let historyButton = TranslucentButton("History")
    lazy var activeGamesButton: UIButton = {
        let gameButton = TranslucentButton("Active Games")
        gameButton.addTarget(self, action: #selector(bringToActiveGames), for: .touchUpInside)
        return gameButton
    }()
    lazy var createButton: UIButton = {
        let gameButton = TranslucentButton("Create")
        gameButton.addTarget(self, action: #selector(bringToCreate), for: .touchUpInside)
        return gameButton
    }()
    @objc
    func bringToActiveGames() {
        push(navigationScreen: .activeGames)
    }
    @objc
    func bringToCreate() {
        push(navigationScreen: .newGame)
    }
    @objc
    func bringToSocial() {
        push(navigationScreen: .social)
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        createButton.topAnchor.constraint(equalTo: margins.topAnchor,
                                          constant: navBarSpacing).isActive = true
        createButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        createButton.widthAnchor.constraint(equalTo: margins.widthAnchor,
                                            multiplier: 0.5,
                                            constant: -horizontalButtonSpacing / 2.0).isActive = true
        historyButton.topAnchor.constraint(equalTo: margins.topAnchor,
                                           constant: navBarSpacing).isActive = true
        historyButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        historyButton.widthAnchor.constraint(equalTo: margins.widthAnchor,
                                             multiplier: 0.5,
                                             constant: -horizontalButtonSpacing / 2.0).isActive = true
        activeGamesButton.topAnchor.constraint(equalTo: createButton.bottomAnchor,
                                               constant: verticalButtonSpacing).isActive = true
        activeGamesButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        activeGamesButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    func addNavButtons() {
        backButton.tintColor = .white
        cameraButton.tintColor = .white
        profileButton.tintColor = .white
        navigationItem.backBarButtonItem = backButton
        navigationItem.leftBarButtonItem = cameraButton
        navigationItem.rightBarButtonItem = profileButton
    }

    func addSubviews() {
        view.addSubview(createButton)
        view.addSubview(historyButton)
        view.addSubview(activeGamesButton)
        addNavButtons()
    }

    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(title: "Main Menu")
    }
}
