//
//  ForgotPasswordViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 3/28/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: RoutedViewController {

    let screenTitle = "Photo Assassin"
    let titleSize: CGFloat = 64.0
    let backgroundGradient = BackgroundGradient()
    let spaceAboveTitle: CGFloat = 60.0
    let resetPasswordHeight: CGFloat = 67.0
    let buttonSpacing: CGFloat = 35.0
    let spacingFromBottom: CGFloat = 10
    lazy var resetPasswordButton: UIButton = {
        let button = LoginRegisterButton("Reset Password", height: resetPasswordHeight)
        button.isEnabled = false
        return button
    }()
    lazy var logInButton: UIButton = {
        let button = LoginRegisterButton("Log In", height: resetPasswordHeight)
        button.isEnabled = true
        return button
    }()
    lazy var appTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = screenTitle
        label.textAlignment = .center
        label.textColor = Colors.text
        label.font = R.font.economicaBold(size: titleSize)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var emailField: UITextField = {
        let field = LoginTextField("Email", isSecure: false, isEmail: true)
        field.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        return field
    }()
    lazy var noAccountLink: UIButton = {
        let button = TransitionLinkButton("No account? Register")
        button.addTarget(self, action: #selector(noAccountTapped), for: .touchUpInside)
        return button
    }()
    func addSubviews() {
        view.addSubview(appTitle)
        view.addSubview(emailField)
        view.addSubview(resetPasswordButton)
        view.addSubview(noAccountLink)
        view.addSubview(logInButton)
        backgroundGradient.addToView(view)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
        backgroundGradient.layoutInView(view)
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide

        appTitle.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor).isActive = true
        appTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        appTitle.topAnchor.constraint(equalTo: margins.topAnchor,
                                      constant: spaceAboveTitle).isActive = true

        emailField.bottomAnchor.constraint(equalTo: resetPasswordButton.topAnchor,
                                           constant: -buttonSpacing).isActive = true
        emailField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        emailField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        resetPasswordButton.bottomAnchor.constraint(equalTo: logInButton.topAnchor,
                                                    constant: -buttonSpacing).isActive = true
        resetPasswordButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        resetPasswordButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        logInButton.bottomAnchor.constraint(equalTo: noAccountLink.topAnchor,
                                            constant: -buttonSpacing).isActive = true
        logInButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        logInButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        noAccountLink.bottomAnchor.constraint(equalTo: margins.bottomAnchor,
                                              constant: -spacingFromBottom).isActive = true
        noAccountLink.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        noAccountLink.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }
    @objc
    func fieldEdited() {
        resetPasswordButton.isEnabled = emailField.text != ""
    }
    @objc
    func noAccountTapped() {
        // FIXME
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
}
