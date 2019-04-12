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
    let bodyAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Colors.seeThroughText,
        .font: R.font.economicaBold.orDefault(size: 24.0)
    ]
    let headingSize: CGFloat = 36.0
    let imageWidthMultiplier: CGFloat = 0.35
    let imageMargin: CGFloat = 15.0
    let imageRounding: CGFloat = 5.0
    let navBarSpacing: CGFloat = 40.0
    let player: Player

    // MARK: - UI elements
    lazy var profilePicture: UIImageView = {
        let view = UIImageView(image: player.profilePicture)
        view.backgroundColor = Colors.subsectionBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = imageRounding
        return view
    }()

    lazy var nameLabel = UILabel(player.name, attributes: [
        .foregroundColor: Colors.text,
        .font: R.font.economicaBold.orDefault(size: headingSize)
    ])

    lazy var usernameLeftLabel = UILabel("Username:", attributes: bodyAttributes)
    lazy var usernameRightLabel = UILabel(player.username,
                                          attributes: bodyAttributes,
                                          align: .right)

    lazy var gamesWonLeftLabel = UILabel("Games Won:", attributes: bodyAttributes)
    lazy var gamesWonRightLabel = UILabel(String(player.stats?.gamesWon ?? 0),
                                          attributes: bodyAttributes,
                                          align: .right)

    lazy var winPercentLeftLabel = UILabel("Win %:", attributes: bodyAttributes)
    lazy var winPercentRightLabel = UILabel(
        "\(Int((player.stats?.winPercentage ?? 0.0) * 100.0))%",
        attributes: bodyAttributes,
        align: .right
    )

    lazy var percentileLeftLabel = UILabel("Percentile:", attributes: bodyAttributes)
    lazy var percentileRightLabel = UILabel(
        "\(Int((player.stats?.percentile ?? 0) * 100.0))%",
        attributes: bodyAttributes,
        align: .right
    )

    lazy var killDeathRatioLeftLabel = UILabel("Kill/Death Ratio:", attributes: bodyAttributes)
    lazy var killDeathRatioRightLabel = UILabel(
        String(format: "%.2f", player.stats?.killDeathRatio ?? 0.0),
        attributes: bodyAttributes,
        align: .right
    )

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

    func addConstraints() {
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
        // Username label constraints
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
