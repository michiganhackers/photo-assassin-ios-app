//
//  AddPlayerViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class AddPlayerViewController: UIViewController {
    // MARK: - Numeric constants
    let mainTextSize: CGFloat = 24.0
    let spaceBetweenTitleAndInviteFieldTitle: CGFloat = 20.0
    let spaceBetweenInviteFieldTitleAndField: CGFloat = 1.0
    let horizontalFieldSpacing: CGFloat = 28.0
    lazy var inviteTitleIndent: CGFloat = horizontalFieldSpacing + 18.0
    let horizontalBarSpacing: CGFloat = 5.5
    let spaceBetweenFieldAndBar: CGFloat = 22.0
    let barHeight: CGFloat = 4.0
    lazy var spaceBetweenUserNameAndInvite: CGFloat = spaceBetweenFieldAndBar
    let spaceBetweenBarAndNearby: CGFloat = 15.0
    let spaceBetweenNearbyLabelAndNearby: CGFloat = 10.0
    let spaceBetweenNearbyAndInviteButton: CGFloat = 20.0

    // MARK: - UI elements
    let gradient = BackgroundGradient()

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.setTitleColor(Colors.seeThroughText, for: .normal)
        button.setTitleColor(Colors.seeThroughContrast, for: .highlighted)
        button.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        return button
    }()

    let titleLabel = UILabel(
        "Add Player to Game",
        attributes: [
            .font: R.font.economicaBold.orDefault(size: 42.0, style: .headline),
            .foregroundColor: Colors.text
        ],
        align: .center
    )

    let inviteLinkField: UITextField = UserEnterTextField("")

    lazy var inviteFieldTitle = UILabel("Invite Link", attributes: [
        .foregroundColor: Colors.seeThroughText,
        .font: R.font.economicaBold.orDefault(size: mainTextSize)
    ])

    lazy var separatingBar: UIView = {
        let separateBar = UIView()
        separateBar.backgroundColor = Colors.seeThroughText
        separateBar.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        separateBar.translatesAutoresizingMaskIntoConstraints = false
        return separateBar
    }()

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

    lazy var separatingBarTwo: UIView = {
        let separateBarTwo = UIView()
        separateBarTwo.backgroundColor = Colors.seeThroughText
        separateBarTwo.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        separateBarTwo.translatesAutoresizingMaskIntoConstraints = false
        return separateBarTwo
    }()

    lazy var nearbyPlayersLabel = UILabel("Nearby Players", attributes: [
        .font: R.font.economicaBold.orDefault(size: mainTextSize),
        .foregroundColor: Colors.seeThroughText
    ])

    lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(
            NSAttributedString(
                string: "Refresh",
                attributes: [
                    .font: R.font.economicaBold.orDefault(size: mainTextSize),
                    .foregroundColor: Colors.text
                ]
            ),
            for: .normal
        )
        button.setAttributedTitle(
            NSAttributedString(
                string: "Refresh",
                attributes: [
                    .font: R.font.economicaBold.orDefault(size: mainTextSize),
                    .foregroundColor: Colors.seeThroughText
                ]
            ),
            for: .highlighted
        )
        button.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        return button
    }()

    let nearbyPlayersVC = InvitePlayerListViewController(
        players: [
            (Player(username: "benjamincarney", name: "Ben", relationship: .none, bio: "Ben's bio"), .notInvited),
            (Player(username: "calvin", name: "Calvin", relationship: .friend, bio: "Calvin's bio"), .invited),
            (Player(username: "brandon", name: "Brandon", relationship: .friend, bio: "Brandon's bio"), .playing)
        ]
    )

    lazy var inviteFromFriendsButton: UIButton = {
        let button = TransparentButton("Invite From Friends")
        button.addTarget(self, action: #selector(inviteFromFriendsButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient.addToView(view)
        addSubviews()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient.layoutInView(view)
        addTitleAndCancelConstraints()
        addInviteByLinkAndUsernameConstraints()
        addNearbyPlayersConstraints()
    }

    // MARK: - Custom functions
    func addSubviews() {
        [
            cancelButton, titleLabel,
            inviteLinkField, inviteFieldTitle,
            separatingBar,
            usernameField, inviteButton,
            separatingBarTwo,
            nearbyPlayersLabel, refreshButton,
            nearbyPlayersVC.view,
            inviteFromFriendsButton
        ].forEach(view.addSubview)
    }

    func addTitleAndCancelConstraints() {
        let margins = view.layoutMarginsGuide

        // cancelButton
        cancelButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        cancelButton.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor).isActive = true
        let cancelButtonLeftConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .left,
            relatedBy: .equal, toItem: margins, attribute: .left,
            multiplier: 1.0, constant: 0.0
        )
        cancelButtonLeftConstraint.priority = .defaultLow
        cancelButtonLeftConstraint.isActive = true
        cancelButton.rightAnchor.constraint(lessThanOrEqualTo: titleLabel.leftAnchor).isActive = true

        // titleLabel
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
    }

    func addInviteByLinkAndUsernameConstraints() {
        let margins = view.layoutMarginsGuide

        // inviteFieldTitle
        inviteFieldTitle.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor,
            constant: spaceBetweenTitleAndInviteFieldTitle).isActive = true
        inviteFieldTitle.leftAnchor.constraint(
            equalTo: margins.leftAnchor,
            constant: inviteTitleIndent).isActive = true
        // inviteLinkField
        inviteLinkField.anchor(
            left: margins.leftAnchor, right: margins.rightAnchor,
            top: inviteFieldTitle.bottomAnchor, bottom: nil,
            marginLeft: horizontalFieldSpacing, marginRight: horizontalFieldSpacing,
            marginTop: spaceBetweenInviteFieldTitleAndField
        )
        // separatingBar
        separatingBar.anchor(
            left: margins.leftAnchor, right: margins.rightAnchor,
            top: inviteLinkField.bottomAnchor, bottom: nil,
            marginLeft: horizontalBarSpacing, marginRight: horizontalBarSpacing,
            marginTop: spaceBetweenFieldAndBar
        )
        // usernameField and inviteButton
        separatingBar.stackViewsDown(
            views: [(usernameField, spaceBetweenFieldAndBar),
                    (inviteButton, spaceBetweenUserNameAndInvite)],
            left: margins.leftAnchor,
            right: margins.rightAnchor,
            marginLeft: horizontalFieldSpacing,
            marginRight: horizontalFieldSpacing
        )
        // second separatingBar
        separatingBarTwo.anchor(
            left: margins.leftAnchor, right: margins.rightAnchor,
            top: inviteButton.bottomAnchor, bottom: nil,
            marginLeft: horizontalBarSpacing, marginRight: horizontalBarSpacing,
            marginTop: spaceBetweenFieldAndBar
        )
    }

    func addNearbyPlayersConstraints() {
        let margins = view.layoutMarginsGuide

        // "Nearby Players" label
        nearbyPlayersLabel.topAnchor.constraint(
            equalTo: separatingBarTwo.bottomAnchor,
            constant: spaceBetweenBarAndNearby).isActive = true
        nearbyPlayersLabel.leftAnchor.constraint(
            equalTo: margins.leftAnchor,
            constant: horizontalFieldSpacing).isActive = true

        // Refresh button
        refreshButton.topAnchor.constraint(
            equalTo: separatingBarTwo.bottomAnchor,
            constant: spaceBetweenBarAndNearby).isActive = true
        refreshButton.rightAnchor.constraint(
            equalTo: margins.rightAnchor,
            constant: -horizontalFieldSpacing).isActive = true

        // "Invite From Friends" button
        inviteFromFriendsButton.anchor(
            left: margins.leftAnchor, right: margins.rightAnchor,
            top: nil, bottom: margins.bottomAnchor,
            marginLeft: horizontalFieldSpacing, marginRight: horizontalFieldSpacing
        )

        // Nearby players table view
        nearbyPlayersVC.view.anchor(
            left: margins.leftAnchor,
            right: margins.rightAnchor,
            top: nearbyPlayersLabel.bottomAnchor,
            bottom: inviteFromFriendsButton.topAnchor,
            marginLeft: horizontalFieldSpacing,
            marginRight: horizontalFieldSpacing,
            marginTop: spaceBetweenNearbyLabelAndNearby,
            marginBottom: spaceBetweenNearbyAndInviteButton)
    }

    // MARK: - Event handlers
    @objc
    func closeViewController() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    @objc
    func usernameFieldEdited() {
        inviteButton.isEnabled = usernameField.text != ""
    }

    @objc
    func inviteByUsernameButtonTapped() {
        print("TODO: invite player with username \(usernameField.text ?? "")")
    }

    @objc
    func inviteFromFriendsButtonTapped() {
        print("TODO: bring up \"Invite From Friends\" screen/dialog")
    }

    @objc
    func refreshButtonTapped() {
        print("TODO: refresh nearby players")
    }
}
