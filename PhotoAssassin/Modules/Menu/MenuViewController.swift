//
//  MenuViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 3/21/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit
import Firebase

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

    lazy var gameLobbyList: GameList<GameLobbyListCell> = {
        let list = GameList<GameLobbyListCell> { lobby, _ in
             //TODO: Grab full lobby info from Firebase
            self.push(navigationScreen: .lobbyInfo(
                LobbyInfo(gameLobby: lobby, focusedPlayer: nil, myselfPermission: .viewer, otherPlayers: [
                    LobbyInfo.PlayerWithStatus(
                        player: Player(username: "Bendudeman", relationship: .none),
                        relationship: .neutral,
                        stats: GameStats(game: lobby, kills: 5)
                    ),
                    LobbyInfo.PlayerWithStatus(
                        player: Player(username: "Owain", relationship: .none),
                        relationship: .target,
                        stats: GameStats(game: lobby, kills: 1)
                    ),
                    LobbyInfo.PlayerWithStatus(
                        player: Player(username: "Vincent", relationship: .none),
                        relationship: .dead,
                        stats: GameStats(game: lobby, kills: 3)
                    )
                    ],
                          startDate: Date(timeIntervalSinceNow: 0.0),
                          endDate: nil)
                ))
        }
    
        
        //DATA STRUCTURE: LobbyInfo contains one gameLobby and gameStats for each player
        var games: [String] = []
        let db = Firestore.firestore()
        
        if let userID = Auth.auth().currentUser?.uid {
            db.collection("games").getDocuments { (querySnapshot, error) in
                
                if let err = error {
                    print("Error: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        
                        var players = [LobbyInfo.PlayerWithStatus]()
                        var currGameLobby : GameLobby?
                        let gameID = document.documentID;
                        let gameStatus = document.get("status") as? String ?? "NO STATUS"
                        if (gameStatus == "notStarted" || gameStatus == "started"){
                            let title = document.get("name") as? String ?? "NO NAME"
                            let numberAlive = document.get("numberAlive") as? Int
                            let maxPlayers = document.get("maxPlayers") as? Int ?? 0
                            var numberInLobby = 0
                            var username = String()
                            let gameRef = db.collection("games").document(gameID)
                            gameRef.collection("players").getDocuments() { (querySnapshot, error) in
                                if let err = error {
                                    print("Error: \(err)")
                                } else {
                                    if let playerCount = querySnapshot?.count {
                                        numberInLobby = playerCount
                                    }
                                    currGameLobby = GameLobby(id: gameID, title: title, numberInLobby: numberInLobby, numberAlive: numberAlive, maxPlayers: maxPlayers)
                                    for player in querySnapshot!.documents{
                                        db.collection("users").document(player.documentID).getDocument { (snapshot, error) in
                                            if let snapshot = snapshot, snapshot.exists{
                                                username = snapshot.value(forKey: "displayName") as? String ?? "NO USERNAME"                                            }
                                        }
                                        let kills = player.get("kills") as? Int
                                        let place = player.get("place") as? Int
                                        let currGameStat = GameStats(game: currGameLobby!, kills: kills, place: place, didGameEnd: gameStatus == "ended" ? true : false)
                                        let currPlayer = Player(username: username, relationship: .none)
                                    }
                                    
                                }
                                list.games.append(currGameLobby!)
                                list.update()
                                
                                self.push(navigationScreen: .lobbyInfo(LobbyInfo(gameLobby: currGameLobby!, focusedPlayer: nil, myselfPermission: .viewer, otherPlayers: players)))
                            }
                            
                            
                        }
                    }
                }
            }
        }
        
        return list;
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
