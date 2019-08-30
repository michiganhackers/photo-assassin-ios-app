//
//  LobbyViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 3/28/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class LobbyViewController: NavigatingViewController {
    // MARK: - Class data members
    static let labelAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Colors.seeThroughText,
        .font: R.font.economicaBold.orDefault(size: 36.0)
    ]
    static let verticalMargin: CGFloat = 20.0
    static let horizontalMargin: CGFloat = 15.0
    let info: LobbyInfo

    // MARK: - UI elements
    lazy var playerList = GameList<LobbyPlayerListCell> { playerWithStatus, _ in
        self.push(navigationScreen: .profile(playerWithStatus.player))
    }
    let joinGameButton = TransparentButton("Join Game")
    let invitePlayersButton = TransparentButton("Invite Players")
    let startGameButton = TransparentButton("Start Game")
    let leaveGameButton = TransparentButton("Leave Game")
    lazy var playersLabel: UILabel = {
        let text = info.isStarted && !info.isEnded ? "Remaining" : "Players"
        return UILabel(text, attributes: LobbyViewController.labelAttributes, align: .left)
    }()
    lazy var playerCountLabel: UILabel = {
        var text = "\(info.allPlayers.count)"
        if info.isStarted && !info.isEnded {
            let alivePlayers = info.allPlayers.filter { playerWithStatus in
                playerWithStatus.relationship != .dead
            }
            text = "\(alivePlayers.count)/" + text
        }
        return UILabel(text, attributes: LobbyViewController.labelAttributes, align: .right)
    }()
    lazy var startLabel: UILabel = {
        let date = info.startDate ?? Date(timeIntervalSince1970: 0.0)
        return UILabel(
            "Started: \(DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none))",
            attributes: type(of: self).labelAttributes,
            align: .left
        )
    }()
    lazy var lengthLabel: UILabel = {
        let startDate = info.startDate ?? Date(timeIntervalSince1970: 0.0)
        let endDate = info.endDate ?? Date(timeIntervalSince1970: 0.0)
        let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
        let days = components.day ?? -1
        return UILabel(
            "Length: \(days) day\(days == 1 ? "" : "s")",
            attributes: type(of: self).labelAttributes,
            align: .left
        )
    }()

    // MARK: - Custom functions
    func addSubviews() {
        view.addSubview(playerList.view)
        if info.canJoin {
            view.addSubview(joinGameButton)
        }
        if info.canInvite {
            view.addSubview(invitePlayersButton)
        }
        if info.canStart {
            view.addSubview(startGameButton)
        }
        view.addSubview(playersLabel)
        view.addSubview(playerCountLabel)
        if info.canLeave {
            view.addSubview(leaveGameButton)
        }
        if info.isEnded {
            view.addSubview(startLabel)
            view.addSubview(lengthLabel)
        }
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        var verticalAnchor = margins.topAnchor
        if info.canJoin {
            joinGameButton.topAnchor.constraint(equalTo: verticalAnchor,
                                                constant: type(of: self).verticalMargin).isActive = true
            joinGameButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
            joinGameButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
            verticalAnchor = joinGameButton.bottomAnchor
        } else if info.canInvite && !info.canStart {
            invitePlayersButton.topAnchor.constraint(equalTo: verticalAnchor,
                                                     constant: type(of: self).verticalMargin).isActive = true
            invitePlayersButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
            invitePlayersButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
            verticalAnchor = invitePlayersButton.bottomAnchor
        } else if info.canInvite && info.canStart {
            invitePlayersButton.topAnchor.constraint(equalTo: verticalAnchor,
                                                     constant: type(of: self).verticalMargin).isActive = true
            invitePlayersButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
            invitePlayersButton.rightAnchor.constraint(equalTo: margins.centerXAnchor,
                                                       constant: -type(of: self).horizontalMargin / 2.0).isActive = true
            startGameButton.topAnchor.constraint(equalTo: verticalAnchor,
                                                 constant: type(of: self).verticalMargin).isActive = true
            startGameButton.leftAnchor.constraint(equalTo: margins.centerXAnchor,
                                                  constant: type(of: self).horizontalMargin / 2.0).isActive = true
            startGameButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
            verticalAnchor = invitePlayersButton.bottomAnchor
        }
        if info.isEnded {
            startLabel.topAnchor.constraint(equalTo: verticalAnchor,
                                            constant: LobbyViewController.verticalMargin).isActive = true
            startLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
            lengthLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor).isActive = true
            lengthLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
            verticalAnchor = lengthLabel.bottomAnchor
        }
        setUpPlayerCountAndLeaveConstraints(verticalAnchor: verticalAnchor)
    }

    func setUpPlayerCountAndLeaveConstraints(verticalAnchor: NSLayoutYAxisAnchor) {
        let margins = view.layoutMarginsGuide
        playersLabel.topAnchor.constraint(equalTo: verticalAnchor,
                                          constant: LobbyViewController.verticalMargin).isActive = true
        playersLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        playerCountLabel.topAnchor.constraint(equalTo: verticalAnchor,
                                              constant: LobbyViewController.verticalMargin).isActive = true
        playerCountLabel.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        playerList.view.topAnchor.constraint(equalTo: playersLabel.bottomAnchor,
                                             constant: LobbyViewController.verticalMargin).isActive = true
        playerList.view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        playerList.view.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        if info.canLeave {
            leaveGameButton.topAnchor.constraint(equalTo: playerList.view.bottomAnchor,
                                                 constant: LobbyViewController.verticalMargin).isActive = true
            leaveGameButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
            leaveGameButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
            leaveGameButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        } else {
            playerList.view.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        }
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

    // MARK: - Event handlers
    @objc
    func joinGameTapped() {
        print("TODO: Join this game")
    }

    @objc
    func invitePlayersTapped() {
        print("TODO: Bring up invite players screen")
    }

    @objc
    func startGameTapped() {
        print("TODO: Start the game")
    }

    @objc
    func leaveGameTapped() {
        print("TODO: Leave the game")
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        self.info = LobbyInfo(gameLobby: GameLobby(id: "", title: "", numberInLobby: 0, capacity: 0),
                              focusedPlayer: nil,
                              myselfPermission: .viewer,
                              otherPlayers: [])
        super.init(coder: aDecoder)
    }

    init(info: LobbyInfo) {
        self.info = info
        super.init(title: info.gameLobby.title)
        playerList.games = info.allPlayers
        joinGameButton.addTarget(self, action: #selector(joinGameTapped), for: .touchUpInside)
        invitePlayersButton.addTarget(self, action: #selector(invitePlayersTapped), for: .touchUpInside)
        startGameButton.addTarget(self, action: #selector(startGameTapped), for: .touchUpInside)
        leaveGameButton.addTarget(self, action: #selector(leaveGameTapped), for: .touchUpInside)
    }
}
