//
//  ChangeEmailViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 6/26/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class ChangeEmailViewController: NavigatingViewController {
    // MARK: - Class constants
    static let labelTextSize: CGFloat = 36.0
    static let fieldSpacing: CGFloat = 30.0

    // MARK: - UI elements
    let currentEmailLabel = TranslucentLabel(text: "Current email", size: labelTextSize)
    let newEmailLabel = TranslucentLabel(text: "New email", size: labelTextSize)
    let passwordLabel = TranslucentLabel(text: "Enter your password", size: labelTextSize)

    let currentEmailField = LoginTextField("Current email", isSecure: false, isEmail: true)
    let newEmailField = LoginTextField("New email", isSecure: false, isEmail: true)
    let passwordField = LoginTextField("Password", isSecure: true, isEmail: false)

    let submitButton: UIButton = {
        let button = TransparentButton("Submit")
        button.isEnabled = false
        return button
    }()

    // MARK: - Custom functions
    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        currentEmailLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        currentEmailLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        currentEmailField.topAnchor.constraint(equalTo:
            currentEmailLabel.bottomAnchor).isActive = true
        currentEmailField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        currentEmailField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        newEmailLabel.topAnchor.constraint(
            equalTo: currentEmailField.bottomAnchor,
            constant: ChangePasswordViewController.fieldSpacing).isActive = true
        newEmailLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        newEmailField.topAnchor.constraint(equalTo: newEmailLabel.bottomAnchor).isActive = true
        newEmailField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        newEmailField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        passwordLabel.topAnchor.constraint(
            equalTo: newEmailField.bottomAnchor,
            constant: ChangePasswordViewController.fieldSpacing).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo:
            passwordLabel.bottomAnchor).isActive = true
        passwordField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        passwordField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        submitButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        submitButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        submitButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    func addSubviews() {
        view.addSubview(currentEmailLabel)
        view.addSubview(newEmailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(currentEmailField)
        view.addSubview(newEmailField)
        view.addSubview(passwordField)
        view.addSubview(submitButton)
    }

    // MARK: - Event listeners
    @objc
    func fieldEdited() {
        submitButton.isEnabled = currentEmailField.text != nil &&
            currentEmailField.text != "" &&
            newEmailField.text != nil &&
            newEmailField.text != "" &&
            passwordField.text != nil &&
            passwordField.text != ""
    }

    @objc
    func submit() {
        print("TODO: Change email")
        currentEmailField.text = ""
        newEmailField.text = ""
        passwordField.text = ""
        pop()
    }

    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(title: "Change Email")
        currentEmailField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        newEmailField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
}
