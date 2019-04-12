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
    let addFriendWidthMultiplier: CGFloat = 0.6
    let bioSpacing: CGFloat = 20.0
    lazy var blockWidthMultiplier: CGFloat = 1 - addFriendWidthMultiplier
    let horizontalButtonSpacing: CGFloat = 10.0
    let imageWidthMultiplier: CGFloat = 0.35
    let imageMargin: CGFloat = 15.0
    let imageRounding: CGFloat = 5.0
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
    let player: Player

    // MARK: - UI elements
    lazy var profilePicture: UIImageView = {
        let view = UIImageView(image: player.profilePicture)
        view.backgroundColor = Colors.subsectionBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = imageRounding
        return view
    }()

    lazy var nameLabel = UILabel(player.name, attributes: headingAttributes)

    lazy var usernameLeftLabel = UILabel("Username:", attributes: fadedBodyAttributes)
    lazy var usernameRightLabel = UILabel(player.username,
                                          attributes: fadedBodyAttributes,
                                          align: .right)

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

    lazy var addFriendButton: UIButton = {
        let button = TranslucentButton("Add Friend")
        button.isEnabled = player.canAddAsFriend()
        return button
    }()

    lazy var blockButton: UIButton = {
        let button = TranslucentButton("Block")
        button.isEnabled = player.canBlock()
        return button
    }()

    lazy var horizontalLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.heightAnchor.constraint(equalToConstant: lineThickness).isActive = true
        line.backgroundColor = Colors.text
        return line
    }()

    lazy var bioLabel = UILabel("Bio", attributes: headingAttributes, align: .center)
    lazy var bioContent: UILabel = {
        let label = UILabel(player.bio, attributes: bodyAttributes)
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Custom functions
    func addSubviews() {
        view.addSubview(profilePicture)
        view.addSubview(nameLabel)
        view.addSubview(usernameLeftLabel)
        view.addSubview(usernameRightLabel)
        view.addSubview(gamesWonLeftLabel)
        view.addSubview(gamesWonRightLabel)
        view.addSubview(winPercentLeftLabel)
        view.addSubview(winPercentRightLabel)
        view.addSubview(percentileLeftLabel)
        view.addSubview(percentileRightLabel)
        view.addSubview(killDeathRatioLeftLabel)
        view.addSubview(killDeathRatioRightLabel)
        view.addSubview(addFriendButton)
        view.addSubview(blockButton)
        view.addSubview(horizontalLine)
        view.addSubview(bioLabel)
        view.addSubview(bioContent)
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

            lastTop = leftLabel.bottomAnchor
        }
    }

    func addImageAndLabelConstraints() {
        let margins = view.layoutMarginsGuide

        // Profile picture constraints
        profilePicture.topAnchor.constraint(equalTo: margins.topAnchor,
                                            constant: navBarSpacing).isActive = true
        profilePicture.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        NSLayoutConstraint(item: profilePicture, attribute: .right,
                           relatedBy: .equal, toItem: margins, attribute: .right,
                           multiplier: imageWidthMultiplier, constant: 0.0).isActive = true
        profilePicture.heightAnchor.constraint(equalTo: profilePicture.widthAnchor).isActive = true

        // Name label constraints
        nameLabel.topAnchor.constraint(equalTo: margins.topAnchor,
                                       constant: navBarSpacing).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profilePicture.rightAnchor,
                                        constant: imageMargin).isActive = true
        // User info label constraints
        addConsecutiveLabelConstraints(
            labelPairs: [
                (usernameLeftLabel, usernameRightLabel),
                (gamesWonLeftLabel, gamesWonRightLabel),
                (winPercentLeftLabel, winPercentRightLabel),
                (percentileLeftLabel, percentileRightLabel),
                (killDeathRatioLeftLabel, killDeathRatioRightLabel)
            ],
            left: profilePicture.rightAnchor,
            right: margins.rightAnchor,
            top: nameLabel.bottomAnchor,
            marginLeft: imageMargin
        )
    }

    func addButtonAndBioConstraints() {
        let margins = view.layoutMarginsGuide

        // "Add Friend"/"Block" button constraints
        blockButton.topAnchor.constraint(
            greaterThanOrEqualTo: profilePicture.bottomAnchor,
            constant: verticalButtonSpacing).isActive = true
        let dynamicButtonY = NSLayoutConstraint(item: blockButton, attribute: .top,
                           relatedBy: .equal, toItem: killDeathRatioLeftLabel, attribute: .bottom,
                           multiplier: 1.0, constant: verticalButtonSpacing)
        dynamicButtonY.priority = .defaultLow
        dynamicButtonY.isActive = true

        blockButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        blockButton.widthAnchor.constraint(
            equalTo: margins.widthAnchor,
            multiplier: blockWidthMultiplier,
            constant: -horizontalButtonSpacing / 2.0).isActive = true

        addFriendButton.topAnchor.constraint(
            equalTo: blockButton.topAnchor).isActive = true
        addFriendButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        addFriendButton.widthAnchor.constraint(
            equalTo: margins.widthAnchor,
            multiplier: addFriendWidthMultiplier,
            constant: -horizontalButtonSpacing / 2.0).isActive = true

        // Horizontal line constraints
        horizontalLine.topAnchor.constraint(
            equalTo: addFriendButton.bottomAnchor,
            constant: verticalButtonSpacing).isActive = true
        horizontalLine.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        horizontalLine.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        // Bio constraints
        bioLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor,
                                      constant: bioSpacing).isActive = true
        bioLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        bioContent.topAnchor.constraint(equalTo: bioLabel.bottomAnchor).isActive = true
        bioContent.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        bioContent.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    func addConstraints() {
        addImageAndLabelConstraints()
        addButtonAndBioConstraints()
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
        self.player = Player.myself
        super.init(coder: aDecoder)
    }
    init(player: Player) {
        self.player = player
        super.init(title: "Profile")
    }
}
