//
//  ChangePasswordViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 6/26/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class ChangePasswordViewController: NavigatingViewController {
    // MARK: - Class constants
    static let labelTextSize: CGFloat = 36.0
    static let fieldSpacing: CGFloat = 30.0

    // MARK: - UI elements
    let currentPasswordLabel = TranslucentLabel(text: "Current password", size: labelTextSize)
    let newPasswordLabel = TranslucentLabel(text: "New password", size: labelTextSize)
    let confirmPasswordLabel = TranslucentLabel(text: "Confirm new password", size: labelTextSize)

    let currentPasswordField = LoginTextField("Current password", isSecure: true, isEmail: false)
    let newPasswordField = LoginTextField("New password", isSecure: true, isEmail: false)
    let confirmPasswordField = LoginTextField("New password", isSecure: true, isEmail: false)

    let submitButton: UIButton = {
        let button = TransparentButton("Submit")
        button.isEnabled = false
        return button
    }()

    // MARK: - Custom functions
    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        currentPasswordLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        currentPasswordLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        currentPasswordField.topAnchor.constraint(equalTo:
            currentPasswordLabel.bottomAnchor).isActive = true
        currentPasswordField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        currentPasswordField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        newPasswordLabel.topAnchor.constraint(
            equalTo: currentPasswordField.bottomAnchor,
            constant: ChangePasswordViewController.fieldSpacing).isActive = true
        newPasswordLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        newPasswordField.topAnchor.constraint(equalTo: newPasswordLabel.bottomAnchor).isActive = true
        newPasswordField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        newPasswordField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        confirmPasswordLabel.topAnchor.constraint(
            equalTo: newPasswordField.bottomAnchor,
            constant: ChangePasswordViewController.fieldSpacing).isActive = true
        confirmPasswordLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        confirmPasswordField.topAnchor.constraint(equalTo:
            confirmPasswordLabel.bottomAnchor).isActive = true
        confirmPasswordField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        confirmPasswordField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        submitButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        submitButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        submitButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    func addSubviews() {
        view.addSubview(currentPasswordLabel)
        view.addSubview(newPasswordLabel)
        view.addSubview(confirmPasswordLabel)
        view.addSubview(currentPasswordField)
        view.addSubview(newPasswordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(submitButton)
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

    // MARK: - Event listeners
    @objc
    func fieldEdited() {
        submitButton.isEnabled = currentPasswordField.text != nil &&
            currentPasswordField.text != "" &&
            newPasswordField.text != nil &&
            newPasswordField.text != "" &&
            confirmPasswordField.text == newPasswordField.text
    }

    @objc
    func submit() {
        print("TODO: Change password")
        currentPasswordField.text = ""
        newPasswordField.text = ""
        confirmPasswordField.text = ""
        pop()
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(title: "Change Password")
        currentPasswordField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        newPasswordField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        confirmPasswordField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }

}
