//
//  LoginViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 2/28/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class LoginViewController: LoginRegisterViewController {
    // MARK: - Text and Number Class Constants
    let linkSpacing: CGFloat = 10.0
    let logoSpacing: CGFloat = 20.0
    let maxLogoSizeMultiplier: CGFloat = 0.5

    // MARK: - UI Elements
    lazy var forgotPasswordLink: UIButton = {
        let link = TransitionLinkButton("Forgot Password?")
        link.addTarget(self, action: #selector(forgotPasswordLinkTapped), for: .touchUpInside)
        return link
    }()

    lazy var registerLink: UIButton = {
        let link = TransitionLinkButton("Register")
        link.addTarget(self, action: #selector(registerLinkTapped), for: .touchUpInside)
        return link
    }()

    lazy var assassinLogo: UIImageView = {
        let logo = UIImageView(image: R.image.assassinLogo())
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    // MARK: - Overrides
    override func addSubviews() {
        super.addSubviews()
        contentView.addSubview(forgotPasswordLink)
        contentView.addSubview(registerLink)
        contentView.addSubview(assassinLogo)
    }

    override func setUpConstraints() {
        super.setUpConstraints()

        let margins = contentView.layoutMarginsGuide

        loginRegisterButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor,
                                                 constant: loginButtonOffset).isActive = true
        loginRegisterButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        loginRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        forgotPasswordLink.topAnchor.constraint(
            equalTo: loginRegisterButton.bottomAnchor,
            constant: linkSpacing).isActive = true
        forgotPasswordLink.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true

        registerLink.topAnchor.constraint(
            equalTo: loginRegisterButton.bottomAnchor,
            constant: linkSpacing).isActive = true
        registerLink.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        assassinLogo.topAnchor.constraint(
            equalTo: registerLink.bottomAnchor,
            constant: logoSpacing).isActive = true
        assassinLogo.centerXAnchor.constraint(
            equalTo: margins.centerXAnchor).isActive = true
        assassinLogo.widthAnchor.constraint(
            lessThanOrEqualTo: margins.widthAnchor,
            multiplier: maxLogoSizeMultiplier).isActive = true
        assassinLogo.heightAnchor.constraint(equalTo: assassinLogo.widthAnchor).isActive = true
    }

    override func getBottomSubview() -> UIView {
        return assassinLogo
    }

    override func getSpaceAboveTitle() -> CGFloat {
        return 95.0
    }

    override func getSpaceBelowTitle() -> CGFloat {
        return 60.0
    }

    override func getTextFieldSeparation() -> CGFloat {
        return loginButtonOffset
    }

    // MARK: - Event Listeners
    @objc
    func registerLinkTapped() {
        routeTo(screen: .register)
    }

    @objc
    func forgotPasswordLinkTapped() {
        routeTo(screen: .forgotPassword)
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(buttonText: "log in",
                   screenTitle: "Photo Assassin") { (_ email: String, _ password: String) -> Void in
            print("Attempted log in with email \(email) and password \(password)")
        }
    }
}
