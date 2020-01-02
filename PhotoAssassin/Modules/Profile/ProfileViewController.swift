//
//  ProfileViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/12/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class ProfileViewController: NavigatingViewController {
    // MARK: - Class members
    let horizontalButtonSpacing: CGFloat = 10.0
    let imageWidthMultiplier: CGFloat = 0.35
    let imageMargin: CGFloat = 15.0
    let imageRounding: CGFloat = 5.0
    let leftRightSeparation: CGFloat = 3.0
    let lineThickness: CGFloat = 3.0
    let navBarSpacing: CGFloat = 40.0
    let verticalButtonSpacing: CGFloat = 15.0

    let bodyAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Colors.text,
        .font: R.font.economicaBold.orDefault(size: 24.0)
    ]
    let fadedBodyAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Colors.seeThroughText,
        .font: R.font.economicaBold.orDefault(size: 24.0)
    ]
    let headingAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Colors.text,
        .font: R.font.economicaBold.orDefault(size: 36.0)
    ]
    let fadedHeadingAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Colors.seeThroughText,
        .font: R.font.economicaBold.orDefault(size: 36.0)
    ]
    let player: Player

    // MARK: - UI elements
    lazy var profilePicture: UIImageView = {
        let view = UIImageView(image: player.profilePicture)
        view.backgroundColor = Colors.subsectionBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = imageRounding
        return view
    }()

    lazy var usernameLabel = UILabel(player.username, attributes: headingAttributes)

    lazy var gamesWonLeftLabel = UILabel("Games Won:", attributes: fadedBodyAttributes)
    lazy var gamesWonRightLabel = UILabel(String(player.stats?.gamesWon ?? 0),
                                          attributes: fadedBodyAttributes,
                                          align: .right)

    lazy var winPercentLeftLabel = UILabel("Win %:", attributes: fadedBodyAttributes)
    lazy var winPercentRightLabel = UILabel(
        "\(Int((player.stats?.winPercentage ?? 0.0) * 100.0))%",
        attributes: fadedBodyAttributes,
        align: .right
    )

    lazy var percentileLeftLabel = UILabel("Percentile:", attributes: fadedBodyAttributes)
    lazy var percentileRightLabel = UILabel(
        "\(Int((player.stats?.percentile ?? 0) * 100.0))%",
        attributes: fadedBodyAttributes,
        align: .right
    )

    lazy var killDeathRatioLeftLabel = UILabel("Kill/Death Ratio:", attributes: fadedBodyAttributes)
    lazy var killDeathRatioRightLabel = UILabel(
        String(format: "%.2f", player.stats?.killDeathRatio ?? 0.0),
        attributes: fadedBodyAttributes,
        align: .right
    )

    lazy var changeFriendStatusButton: UIButton = {
        let text = player.relationship == .friend ? "Unfriend" : "Add Friend"
        let button = TranslucentButton(text)
        button.addTarget(self, action: #selector(changeFriendStatus), for: .touchUpInside)
        return button
    }()

    lazy var historyButton: UIButton = {
        let button = TranslucentButton("Game History")
        button.addTarget(self, action: #selector(openGameHistory), for: .touchUpInside)
        return button
    }()

    lazy var horizontalLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.heightAnchor.constraint(equalToConstant: lineThickness).isActive = true
        line.backgroundColor = Colors.text
        return line
    }()

    lazy var userSearchField: UITextField = {
        let field = UserEnterTextField("Search User")
        let searchButton = UIButton(type: .custom)
        searchButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        searchButton.setImage(R.image.search()?.withRenderingMode(.alwaysTemplate), for: .normal)
        searchButton.addTarget(self, action: #selector(searchForUser), for: .touchUpInside)
        field.rightView = searchButton
        field.rightViewMode = .always
        field.tintColor = Colors.text
        field.returnKeyType = .search
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }()

    lazy var friendsLabel = UILabel("Friends", attributes: fadedHeadingAttributes, align: .left)
    lazy var friendList = PlayerListViewController(players: [], hasGradientBackground: false) { player, _ in
        self.push(navigationScreen: .profile(player))
    }

    // MARK: - Custom functions
    func addSubviews() {
        view.addSubview(profilePicture)
        view.addSubview(usernameLabel)
        view.addSubview(gamesWonLeftLabel)
        view.addSubview(gamesWonRightLabel)
        view.addSubview(winPercentLeftLabel)
        view.addSubview(winPercentRightLabel)
        view.addSubview(percentileLeftLabel)
        view.addSubview(percentileRightLabel)
        view.addSubview(killDeathRatioLeftLabel)
        view.addSubview(killDeathRatioRightLabel)
        if player.relationship != .myself {
            view.addSubview(changeFriendStatusButton)
        } else {
            view.addSubview(userSearchField)
        }
        view.addSubview(historyButton)
        view.addSubview(horizontalLine)
        view.addSubview(friendsLabel)
        view.addSubview(friendList.view)
    }

    func addConsecutiveLabelConstraints(
        labelPairs: [(UILabel, UILabel)],
        left: NSLayoutXAxisAnchor,
        right: NSLayoutXAxisAnchor,
        top: NSLayoutYAxisAnchor,
        marginLeft: CGFloat = 0.0,
        marginRight: CGFloat = 0.0
    ) {
        var lastTop = top
        for (leftLabel, rightLabel) in labelPairs {
            leftLabel.leftAnchor.constraint(
                equalTo: left,
                constant: marginLeft
            ).isActive = true

            leftLabel.topAnchor.constraint(
                equalTo: lastTop
            ).isActive = true

            rightLabel.rightAnchor.constraint(
                equalTo: right,
                constant: marginRight
            ).isActive = true

            rightLabel.topAnchor.constraint(
                equalTo: lastTop
            ).isActive = true

            rightLabel.leftAnchor.constraint(
                greaterThanOrEqualTo: leftLabel.rightAnchor,
                constant: leftRightSeparation
            ).isActive = true

            lastTop = leftLabel.bottomAnchor
        }
    }

    func addImageAndLabelConstraints() {
        let margins = view.layoutMarginsGuide

        // Profile picture constraints
        profilePicture.topAnchor.constraint(equalTo: margins.topAnchor,
                                            constant: navBarSpacing).isActive = true
        profilePicture.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true

        let imageRightConstraint = NSLayoutConstraint(
            item: profilePicture, attribute: .right,
            relatedBy: .equal, toItem: margins, attribute: .right,
            multiplier: imageWidthMultiplier, constant: 0.0
        )
        imageRightConstraint.priority = .defaultLow
        imageRightConstraint.isActive = true

        profilePicture.heightAnchor.constraint(equalTo: profilePicture.widthAnchor).isActive = true

        // Username label constraints
        usernameLabel.topAnchor.constraint(equalTo: margins.topAnchor,
                                           constant: navBarSpacing).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profilePicture.rightAnchor,
                                            constant: imageMargin).isActive = true
        // User info label constraints
        addConsecutiveLabelConstraints(
            labelPairs: [
                (gamesWonLeftLabel, gamesWonRightLabel),
                (winPercentLeftLabel, winPercentRightLabel),
                (percentileLeftLabel, percentileRightLabel),
                (killDeathRatioLeftLabel, killDeathRatioRightLabel)
            ],
            left: profilePicture.rightAnchor,
            right: margins.rightAnchor,
            top: usernameLabel.bottomAnchor,
            marginLeft: imageMargin
        )
    }

    @objc
    func openGameHistory() {
        push(navigationScreen: .gameHistory(self.player))
    }

    @objc
    func changeFriendStatus() {
        print("TODO: Change friend status to isFriend == \(player.relationship != .friend)")
    }

    @objc
    func searchForUser() {
        if let username = userSearchField.text {
            print("TODO: Find user with username \(username)")
            push(navigationScreen: .profile(Player(uid: "TODO", username: username, relationship: .none)))
        }
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

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        self.player = Player(uid: "", username: "", relationship: .none)
        super.init(coder: aDecoder)
    }
    init(player: Player) {
        self.player = player
        super.init(title: "Profile")
        self.player.loadFriends { friends in
            friendList.update(newPlayers: friends)
        }
    }
}

extension ProfileViewController {
    /* More constraints and overrides */
    func addButtonAndFriendListConstraints() {
        let margins = view.layoutMarginsGuide

        // "Add Friend"/"Unfriend"/"Game History" button constraints
        historyButton.topAnchor.constraint(
            greaterThanOrEqualTo: profilePicture.bottomAnchor,
            constant: verticalButtonSpacing).isActive = true
        let dynamicButtonY = NSLayoutConstraint(item: historyButton, attribute: .top,
                                                relatedBy: .equal, toItem: killDeathRatioLeftLabel, attribute: .bottom,
                                                multiplier: 1.0, constant: verticalButtonSpacing)
        dynamicButtonY.priority = .defaultLow
        dynamicButtonY.isActive = true

        historyButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        if player.relationship == .myself {
            historyButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        } else {
            historyButton.widthAnchor.constraint(
                equalTo: margins.widthAnchor, multiplier: 0.5,
                constant: -horizontalButtonSpacing / 2.0).isActive = true
            changeFriendStatusButton.topAnchor.constraint(equalTo: historyButton.topAnchor).isActive = true
            changeFriendStatusButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
            changeFriendStatusButton.widthAnchor.constraint(
                equalTo: margins.widthAnchor, multiplier: 0.5,
                constant: -horizontalButtonSpacing / 2.0).isActive = true
        }

        // Horizontal line constraints
        horizontalLine.topAnchor.constraint(equalTo: historyButton.bottomAnchor,
                                            constant: verticalButtonSpacing).isActive = true
        horizontalLine.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        horizontalLine.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        if player.relationship == .myself {
            userSearchField.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor,
                                                 constant: verticalButtonSpacing).isActive = true
            userSearchField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
            userSearchField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
            friendsLabel.topAnchor.constraint(equalTo: userSearchField.bottomAnchor,
                                              constant: verticalButtonSpacing).isActive = true
        } else {
            friendsLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor,
                                              constant: verticalButtonSpacing).isActive = true
        }

        // Friend list constraints
        friendsLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        friendList.view.topAnchor.constraint(equalTo: friendsLabel.bottomAnchor).isActive = true
        friendList.view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        friendList.view.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        friendList.view.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

    func addConstraints() {
        addImageAndLabelConstraints()
        addButtonAndFriendListConstraints()
    }
}
