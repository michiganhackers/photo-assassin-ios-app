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
    let logoSpacing: CGFloat = 10.0

    // MARK: - UI Elements
    lazy var registerLink: UIButton = {
        let link = TransitionLinkButton("Register")
        return link
    }()

    lazy var assassinLogo: UIImageView = {
        // TODO
        let logo = UIImageView(frame: .zero)
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    // MARK: - Overrides
    override func addSubviews() {
        super.addSubviews()
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

        registerLink.topAnchor.constraint(
            equalTo: loginRegisterButton.bottomAnchor,
            constant: linkSpacing).isActive = true
        registerLink.centerXAnchor.constraint(
            equalTo: loginRegisterButton.centerXAnchor).isActive = true

        assassinLogo.topAnchor.constraint(equalTo: registerLink.bottomAnchor).isActive = true
        assassinLogo.centerXAnchor.constraint(
            equalTo: registerLink.centerXAnchor).isActive = true
    }

    override func getBottomSubview() -> UIView {
        return assassinLogo
    }

    override func getTextFieldSeparation() -> CGFloat {
        return loginButtonOffset
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
