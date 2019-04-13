//
//  AddPlayerViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class AddPlayerViewController: UIViewController {
    let mainTextSize: CGFloat = 24.0
    let spaceBetweenTitleAndInviteFieldTitle: CGFloat = 20.0
    let spaceBetweenInviteFieldTitleAndField: CGFloat = 1.0
    let horizontalFieldSpacing: CGFloat = 28.0
    lazy var inviteTitleIndent: CGFloat = horizontalFieldSpacing + 18.0
    let horizontalBarSpacing: CGFloat = 5.5
    let spaceBetweenFieldAndBar: CGFloat = 22.0
    let barHeight: CGFloat = 4.0
    lazy var spaceBetweenUserNameAndInvite: CGFloat = spaceBetweenFieldAndBar

    // MARK: - UI elements
    let gradient = BackgroundGradient()

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.setTitleColor(Colors.seeThroughText, for: .normal)
        button.setTitleColor(Colors.seeThroughContrast, for: .focused)
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

    lazy var inviteLinkField: UITextField = {
        let inviteField = UserEnterTextField("")
        return inviteField
    }()

    lazy var inviteFieldTitle: UILabel = {
        let inviteTitle = UILabel()
        inviteTitle.attributedText = NSAttributedString(
            string: "Invite Link",
            attributes: [
                .foregroundColor: Colors.seeThroughText,
                .font: R.font.economicaBold.orDefault(size: mainTextSize)
            ]
        )
        inviteTitle.translatesAutoresizingMaskIntoConstraints = false
        return inviteTitle
    }()

    lazy var separatingBar: UIView = {
        let separateBar = UIView()
        separateBar.backgroundColor = Colors.seeThroughText
        separateBar.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        separateBar.translatesAutoresizingMaskIntoConstraints = false
        return separateBar
    }()

    lazy var userNameField: UITextField = {
        let userField = UserEnterTextField("Username")
        return userField
    }()

    lazy var inviteButton: UIButton = {
        let button = TransparentButton("Invite")
        return button
    }()

    lazy var separatingBarTwo: UIView = {
        let separateBarTwo = UIView()
        separateBarTwo.backgroundColor = Colors.seeThroughText
        separateBarTwo.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        separateBarTwo.translatesAutoresizingMaskIntoConstraints = false
        return separateBarTwo
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        gradient.addToView(view)
        addSubviews()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient.layoutInView(view)
        setUpConstraints()
    }

    // MARK: - Custom functions
    func addSubviews() {
        view.addSubview(cancelButton)
        view.addSubview(titleLabel)
        view.addSubview(inviteLinkField)
        view.addSubview(inviteFieldTitle)
        view.addSubview(separatingBar)
        view.addSubview(userNameField)
        view.addSubview(inviteButton)
        view.addSubview(separatingBarTwo)
        view.addSubview(titleLabel)
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
    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        addTitleAndCancelConstraints()
        // inviteFieldTitle
        inviteFieldTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                              constant: spaceBetweenTitleAndInviteFieldTitle).isActive = true
        inviteFieldTitle.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                              constant: inviteTitleIndent).isActive = true
        // inviteLinkField
        inviteLinkField.topAnchor.constraint(equalTo: inviteFieldTitle.bottomAnchor,
                                          constant: spaceBetweenInviteFieldTitleAndField).isActive = true
        inviteLinkField.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                          constant: horizontalFieldSpacing).isActive = true
        inviteLinkField.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                          constant: -horizontalFieldSpacing).isActive = true
        // separatingBar
        separatingBar.topAnchor.constraint(equalTo: inviteLinkField.bottomAnchor,
                                           constant: spaceBetweenFieldAndBar).isActive = true
        separatingBar.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                           constant: horizontalBarSpacing).isActive = true
        separatingBar.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                            constant: -horizontalBarSpacing).isActive = true
        // userNameField
        userNameField.topAnchor.constraint(equalTo: separatingBar.bottomAnchor,
                                           constant: spaceBetweenFieldAndBar).isActive = true
        userNameField.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                           constant: horizontalFieldSpacing).isActive = true
        userNameField.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                            constant: -horizontalFieldSpacing).isActive = true
        // inviteButton
        inviteButton.topAnchor.constraint(equalTo: userNameField.bottomAnchor,
                                          constant: spaceBetweenUserNameAndInvite).isActive = true
        inviteButton.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                          constant: horizontalFieldSpacing).isActive = true
        inviteButton.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                          constant: -horizontalFieldSpacing).isActive = true
        // second separatingBar
        separatingBarTwo.topAnchor.constraint(equalTo: inviteButton.bottomAnchor,
                                              constant: spaceBetweenFieldAndBar).isActive = true
        separatingBarTwo.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                              constant: horizontalBarSpacing).isActive = true
        separatingBarTwo.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                               constant: -horizontalBarSpacing).isActive = true
    }

    // MARK: - Event handlers
    @objc
    func closeViewController() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
