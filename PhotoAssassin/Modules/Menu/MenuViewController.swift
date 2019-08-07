//
//  MenuViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 3/21/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class MenuViewController: NavigatingViewController {
    // MARK: - Class Constants
    let gameLobbyHeightRatio: CGFloat = 0.3
    let horizontalButtonSpacing: CGFloat = 12.0
    let navBarSpacing: CGFloat = 20.0
    let verticalButtonSpacing: CGFloat = 18.0

    // MARK: - UI Elements
    let fadedHeadingAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Colors.seeThroughText,
        .font: R.font.economicaBold.orDefault(size: 36.0)
    ]
    
    let gameLobbyList = GameLobbyList()
    
    lazy var lobbiesLabel = UILabel("Lobbies", attributes: fadedHeadingAttributes, align: .left)
    
    lazy var settingsButton = UIBarButtonItem(image: R.image.settingsIcon(),
                                              style: .plain,
                                              target: self,
                                              action: #selector(bringToSettings))

    lazy var profileButton = UIBarButtonItem(image: R.image.profileLogo(),
                                             style: .plain,
                                             target: self,
                                             action: #selector(bringToProfile))

    lazy var createButton: UIButton = {
        let gameButton = TranslucentButton("Create Game")
        gameButton.addTarget(self, action: #selector(bringToCreate), for: .touchUpInside)
        return gameButton
    }()

    // MARK: - Custom Functions
    @objc
    func bringToCreate() {
        push(navigationScreen: .newGame)
    }
    @objc
    func bringToSettings() {
        push(navigationScreen: .settings)
    }
    @objc
    func bringToProfile() {
        push(navigationScreen: .profile(Player.myself))
    }
    @objc
    func onSwipeRight(_ recognizer: UIGestureRecognizer) {
        if recognizer.state == .ended {
            routeTo(screen: .camera, animatedWithOptions: [.transitionFlipFromLeft])
        }
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        createButton.topAnchor.constraint(equalTo: margins.topAnchor,
                                          constant: navBarSpacing).isActive = true
        createButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        createButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        
        lobbiesLabel.topAnchor.constraint(equalTo: createButton.bottomAnchor,
                                          constant: verticalButtonSpacing).isActive = true
        lobbiesLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        
        gameLobbyList.view.topAnchor.constraint(equalTo: lobbiesLabel.bottomAnchor).isActive = true
        gameLobbyList.view.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        gameLobbyList.view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        gameLobbyList.view.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    func addNavButtons() {
        settingsButton.tintColor = .white
        profileButton.tintColor = .white
        navigationItem.leftBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem = profileButton
    }

    func addSubviews() {
        view.addSubview(createButton)
        view.addSubview(lobbiesLabel)
        view.addSubview(gameLobbyList.view)
        addNavButtons()
    }

    func setUpGestures() {
        view.isUserInteractionEnabled = true
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeRight))
        recognizer.direction = .right
        recognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(recognizer)
    }

    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGestures()
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
