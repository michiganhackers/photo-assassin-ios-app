//
//  InvitePlayersViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class InvitePlayersViewController: NavigatingViewController {
    // MARK: - Numeric constants
    let spaceBetweenTitleAndUsername: CGFloat = 30.0
    let horizontalFieldSpacing: CGFloat = 28.0
    let horizontalBarSpacing: CGFloat = 5.5
    let spaceBetweenFieldAndBar: CGFloat = 22.0
    let barHeight: CGFloat = 4.0
    lazy var spaceBetweenUsernameAndInvite: CGFloat = spaceBetweenFieldAndBar
    let spaceBetweenBarAndFriends: CGFloat = 15.0
    let spaceBetweenFriendsLabelAndFriends: CGFloat = 10.0
    let spaceBetweenFriendsAndBottom: CGFloat = 20.0

    // MARK: - Class Members
    var invitedPlayers: Set<String>
    let onClose: ((Set<String>) -> Void)?

    // MARK: - UI elements
    lazy var usernameField: UITextField = {
        let userField = UserEnterTextField("Username")
        userField.addTarget(self, action: #selector(usernameFieldEdited), for: .editingChanged)
        return userField
    }()

    lazy var inviteButton: UIButton = {
        let button = TransparentButton("Invite")
        button.isEnabled = false
        button.addTarget(self, action: #selector(inviteByUsernameButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var separatingBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = Colors.seeThroughText
        bar.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()

    lazy var friendsLabel = UILabel("Friends", attributes: [
        .font: R.font.economicaBold.orDefault(size: 36.0),
        .foregroundColor: Colors.seeThroughText
    ])

    lazy var friendsListVC = InvitePlayerListViewController(
        players: [
            (Player(uid: "ben", username: "benjamincarney", relationship: .friend, profilePicture: "TODO"), .notInvited),
            (Player(uid: "calvin", username: "calvin", relationship: .friend, profilePicture: "TODO"), .invited),
            (Player(uid: "brandon", username: "brandon", relationship: .friend, profilePicture: "TODO"), .notInvited)
        ]
    ) { username in
        self.invitedPlayers.insert(username)
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraints()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onClose?(invitedPlayers)
    }

    // MARK: - Custom functions
    func addSubviews() {
        view.addSubview(usernameField)
        view.addSubview(inviteButton)
        view.addSubview(separatingBar)
        view.addSubview(friendsLabel)
        view.addSubview(friendsListVC.view)
    }

    func addConstraints() {
        let margins = view.layoutMarginsGuide
        // "Username" field
        usernameField.topAnchor.constraint(equalTo: margins.topAnchor,
                                           constant: spaceBetweenTitleAndUsername).isActive = true
        usernameField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        usernameField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        // "Invite" button
        inviteButton.topAnchor.constraint(equalTo: usernameField.bottomAnchor,
                                          constant: spaceBetweenUsernameAndInvite).isActive = true
        inviteButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        inviteButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        // Horizontal separating bar
        separatingBar.anchor(
            left: margins.leftAnchor, right: margins.rightAnchor,
            top: inviteButton.bottomAnchor, bottom: nil,
            marginLeft: horizontalBarSpacing, marginRight: horizontalBarSpacing,
            marginTop: spaceBetweenFieldAndBar
        )

        // "Friends" label
        friendsLabel.topAnchor.constraint(
            equalTo: separatingBar.bottomAnchor,
            constant: spaceBetweenBarAndFriends).isActive = true
        friendsLabel.leftAnchor.constraint(
            equalTo: margins.leftAnchor,
            constant: horizontalFieldSpacing).isActive = true

        // Friends list table view
        friendsListVC.view.anchor(
            left: margins.leftAnchor,
            right: margins.rightAnchor,
            top: friendsLabel.bottomAnchor,
            bottom: margins.bottomAnchor,
            marginLeft: horizontalFieldSpacing,
            marginRight: horizontalFieldSpacing,
            marginTop: spaceBetweenFriendsLabelAndFriends,
            marginBottom: spaceBetweenFriendsAndBottom
        )
    }

    // MARK: - Event handlers
    @objc
    func usernameFieldEdited() {
        inviteButton.isEnabled = usernameField.text != ""
    }

    @objc
    func inviteByUsernameButtonTapped() {
        if let username = usernameField.text {
            invitedPlayers.insert(username)
            usernameField.text = ""
        }
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        self.invitedPlayers = Set<String>()
        self.onClose = nil
        super.init(coder: aDecoder)
    }

    init(alreadyInvited: Set<String>, onClose: @escaping (Set<String>) -> Void) {
        self.invitedPlayers = alreadyInvited
        self.onClose = onClose
        super.init(title: "Invite Players")
    }
}
