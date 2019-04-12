//
//  SocialViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class SocialViewController: NavigatingViewController {
    // MARK: - Class constants
    let addFriendButtonSpacing: CGFloat = 15.0
    let mainTextSize: CGFloat = 36.0
    let playerListHeight: CGFloat = 250.0
    let usernameFieldSpacing: CGFloat = 25.0

    // MARK: - UI elements
    lazy var profileButton = UIBarButtonItem(
        image: R.image.profileLogo(),
        style: .plain,
        target: self,
        action: #selector(transitionToProfile)
    )

    lazy var friendsLabel = UILabel("Friends", attributes: [
        .foregroundColor: Colors.seeThroughText,
        .font: R.font.economicaBold.orDefault(size: mainTextSize)
    ])

    let playerList = PlayerListViewController(
        players: [
            Player(username: "benjamincarney", name: "Ben", relationship: .none),
            Player(username: "phoebe", name: "Phoebe", relationship: .friend),
            Player(username: "casper-h", name: "Casper", relationship: .friend),
            Player(username: "tanner", name: "Tanner", relationship: .none),
            Player(username: "thomasebsmith", name: "Thomas", relationship: .none)
        ],
        hasGradientBackground: false
    )

    let usernameField: UITextField = {
        let field = UserEnterTextField("Username")
        field.addTarget(self, action: #selector(usernameFieldEdited), for: .editingChanged)
        return field
    }()

    let addFriendButton: UIButton = {
        let button = TransparentButton("Add Friend")
        button.isEnabled = false
        return button
    }()

    // MARK: - Event listeners
    @objc
    func transitionToProfile() {
        push(navigationScreen: .profile(Player.myself))
    }

    @objc
    func usernameFieldEdited() {
        addFriendButton.isEnabled = usernameField.text != ""
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavButtons()
        addSubviews()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraints()
    }

    // MARK: - Custom methods
    func addNavButtons() {
        profileButton.tintColor = .white
        navigationItem.rightBarButtonItem = profileButton
    }

    func addSubviews() {
        view.addSubview(friendsLabel)
        view.addSubview(playerList.view)
        view.addSubview(usernameField)
        view.addSubview(addFriendButton)
    }

    func addConstraints() {
        let margins = view.layoutMarginsGuide

        // Friends label constraints
        friendsLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        friendsLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true

        // Player list constraints
        playerList.view.topAnchor.constraint(equalTo: friendsLabel.bottomAnchor).isActive = true
        playerList.view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        playerList.view.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        playerList.view.heightAnchor.constraint(equalToConstant: playerListHeight).isActive = true

        // Username field constraints
        usernameField.topAnchor.constraint(equalTo: playerList.view.bottomAnchor,
                                           constant: usernameFieldSpacing).isActive = true
        usernameField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        usernameField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        // "Add Friend" button constraints
        addFriendButton.topAnchor.constraint(equalTo: usernameField.bottomAnchor,
                                             constant: addFriendButtonSpacing).isActive = true
        addFriendButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        addFriendButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(title: "Social")
    }
}
