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
    let mainTextSize: CGFloat = 36.0
    let playerListHeight: CGFloat = 250.0
    let usernameFieldSpacing: CGFloat = 25.0

    // MARK: - UI elements
    let profileButton = UIBarButtonItem(image: R.image.profileLogo(), style: .plain, target: nil, action: nil)
    lazy var friendsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(
            string: "Friends",
            attributes: [
                .foregroundColor: Colors.seeThroughText,
                .font: R.font.economicaBold.orDefault(size: mainTextSize)
            ]
        )
        return label
    }()
    let playerList = PlayerListViewController(
        players: [
            Player(username: "benjamincarney", name: "Ben", isYourFriend: false),
            Player(username: "phoebe", name: "Phoebe", isYourFriend: true),
            Player(username: "casper-h", name: "Casper", isYourFriend: true),
            Player(username: "tanner", name: "Tanner", isYourFriend: false),
            Player(username: "thomasebsmith", name: "Thomas", isYourFriend: false)
        ],
        hasGradientBackground: false
    )
    
    lazy var usernameField: UITextField = {
        let field = UserEnterTextField("Username")
        return field
    }()

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(title: "Social")
    }
}
