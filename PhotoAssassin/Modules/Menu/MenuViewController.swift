//
//  MenuViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 3/21/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import Firebase
import UIKit

class MenuViewController: NavigatingViewController {
    // MARK: - Class Constants
    let gameLobbyHeightRatio: CGFloat = 0.3
    let horizontalButtonSpacing: CGFloat = 12.0
    let navBarSpacing: CGFloat = 20.0
    let verticalButtonSpacing: CGFloat = 18.0

    // MARK: - Private Members
    private let backend = BackendCaller()

    // MARK: - UI Elements
    let fadedHeadingAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Colors.seeThroughText,
        .font: R.font.economicaBold.orDefault(size: 36.0)
    ]

    lazy var gameLobbyList: GameList<GameLobbyListCell> = {

        var list = GameList<GameLobbyListCell> { lobby, _ in
            Player.getMyself { myself in
                guard let myself = myself else {
                    return
                }
                self.backend.lobbyInfo(for: lobby, focused: myself) { lobbyInfo in
                    guard let lobbyInfo = lobbyInfo else {
                        return
                    }
                    self.push(navigationScreen: .lobbyInfo(lobbyInfo))
                }
            }
        }
        return list
    }()

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
        Player.getMyself { myself in
            if let myself = myself {
                self.push(navigationScreen: .profile(myself))
            }
        }
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
    func gameLobbyUpdate() {
        gameLobbyList.games = []
        let database = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        database.collection("games").getDocuments { querySnapshot, error in
            if let err = error {
                print("Error: \(err)")
                return
            }
            guard let querySnapshot = querySnapshot else {
                print("Could not retrieve current games")
                return
            }
            for document in querySnapshot.documents {
                let gameID = document.documentID
                let gameStatus = document.get("status") as? String ?? "NO STATUS"
                if gameStatus == "notStarted" || gameStatus == "started" {
                    let title = document.get("name") as? String ?? "NO NAME"
                    let numberAlive = document.get("numberAlive") as? Int
                    let maxPlayers = document.get("maxPlayers") as? Int ?? 0
                    var numberInLobby = 1
//                    var username = String()
                    let gameRef = database.collection("games").document(gameID)
                    gameRef.collection("players").getDocuments { querySnapshot, error in
                        guard let querySnapshot = querySnapshot else {
                            return
                        }
                        if let err = error {
                            print("Error: \(err)")
                        } else {
                                numberInLobby = querySnapshot.count
                            let currGameLobby = GameLobby(
                                id: gameID,
                                title: title,
                                numberInLobby: numberInLobby,
                                numberAlive: numberAlive,
                                maxPlayers: maxPlayers
                            )
                            var exists = false
                            for document in querySnapshot.documents where
                                document.documentID == uid {
                                    exists = true
                                    break
                            }
                            if !exists {
                                return
                            }
                            self.gameLobbyList.games.append(currGameLobby)
                            self.gameLobbyList.update()
                        }
                    }
                }
            }
        }
    }

    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        gameLobbyUpdate()
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
