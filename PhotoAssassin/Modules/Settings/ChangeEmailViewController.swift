//
//  ChangeEmailViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 6/26/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit

class ChangeEmailViewController: NavigatingViewController {
    // MARK: - Class constants
    static let labelTextSize: CGFloat = 36.0
    static let fieldSpacing: CGFloat = 30.0

    // MARK: - UI elements
    let currentEmailLabel = TranslucentLabel(text: "Current Email:", size: labelTextSize)
    let emailLabel = TranslucentLabel(text: Auth.auth().currentUser?.email ?? "", size: labelTextSize)
    let newEmailLabel = TranslucentLabel(text: "New Email", size: labelTextSize)
    let confirmNewEmailLabel = TranslucentLabel(text: "Confirm New Email", size: labelTextSize)
    let passwordLabel = TranslucentLabel(text: "Enter your password", size: labelTextSize)

    let newEmailField = LoginTextField("New Email", isSecure: false, isEmail: true)
    let passwordField = LoginTextField("Password", isSecure: true, isEmail: false)
    let confirmNewEmailField = LoginTextField("Confirm New Email", isSecure: false, isEmail: true)

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
        emailLabel.topAnchor.constraint(equalTo: currentEmailLabel.bottomAnchor).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true

        newEmailLabel.topAnchor.constraint(
            equalTo: emailLabel.bottomAnchor,
            constant: ChangePasswordViewController.fieldSpacing).isActive = true
        newEmailLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        newEmailField.topAnchor.constraint(equalTo: newEmailLabel.bottomAnchor).isActive = true
        newEmailField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        newEmailField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        confirmNewEmailLabel.topAnchor.constraint(equalTo: newEmailField.bottomAnchor,
            constant: ChangePasswordViewController.fieldSpacing).isActive = true
        confirmNewEmailLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        confirmNewEmailField.topAnchor.constraint(equalTo: confirmNewEmailLabel.bottomAnchor).isActive = true
        confirmNewEmailField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        confirmNewEmailField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        passwordLabel.topAnchor.constraint(
            equalTo: confirmNewEmailField.bottomAnchor,
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
        view.addSubview(emailLabel)
        view.addSubview(newEmailLabel)
        view.addSubview(confirmNewEmailLabel)
        view.addSubview(confirmNewEmailField)
        view.addSubview(passwordLabel)
        view.addSubview(newEmailField)
        view.addSubview(passwordField)
        view.addSubview(submitButton)
    }

    // MARK: - Event listeners
    @objc
    func fieldEdited() {
        submitButton.isEnabled =
            newEmailField.text != nil &&
            newEmailField.text != "" &&
            confirmNewEmailField.text == newEmailField.text &&
            passwordField.text != nil &&
            passwordField.text != ""
    }

    @objc
    func submit() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        guard let email = currentUser.email, let password = passwordField.text else {
            return
        }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        currentUser.reauthenticate(with: credential) { _, error in
            if let error = error {
                print("Error reauthenticating: \(error)")
                return
            }
            let newEmail: String = self.newEmailField.text ?? ""
            currentUser.updateEmail(to: newEmail) { error in
                if let error = error {
                    print("Error updating email: \(error)")
                    return
                }
                self.emailLabel.setText(text: newEmail)
            }
            self.newEmailField.text = ""
            self.confirmNewEmailField.text = ""
            self.passwordField.text = ""

            self.pop()
        }
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
        newEmailField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        confirmNewEmailField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
}
