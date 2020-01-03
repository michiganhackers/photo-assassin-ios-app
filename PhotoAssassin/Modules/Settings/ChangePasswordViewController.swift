//
//  ChangePasswordViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 6/26/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import UIKit

class ChangePasswordViewController: NavigatingViewController, UITextFieldDelegate {
    // MARK: - Class constants
    static let labelTextSize: CGFloat = 36.0
    static let fieldSpacing: CGFloat = 30.0

    // MARK: - UI Elements
    let currentEmail = TranslucentLabel(text: "Current Email", size: labelTextSize)
    let currentPasswordLabel = TranslucentLabel(text: "Current password", size: labelTextSize)
    let newPasswordLabel = TranslucentLabel(text: "New password", size: labelTextSize)
    let confirmPasswordLabel = TranslucentLabel(text: "Confirm new password", size: labelTextSize)

    lazy var currentEmailField: UITextField = {
        let field = LoginTextField("Current Email", isSecure: false, isEmail: true)
        field.delegate = self as UITextFieldDelegate
        field.translatesAutoresizingMaskIntoConstraints = false
        field.returnKeyType = .done
        return field
    }()

    lazy var currentPasswordField: UITextField = {
        let field = LoginTextField("Current password", isSecure: true, isEmail: false)
        field.delegate = self as UITextFieldDelegate
        field.translatesAutoresizingMaskIntoConstraints = false
        field.returnKeyType = .done
        return field
    }()

    lazy var newPasswordField: UITextField = {
        let field = LoginTextField("New password", isSecure: true, isEmail: false)
        field.delegate = self as UITextFieldDelegate
        field.translatesAutoresizingMaskIntoConstraints = false
        field.returnKeyType = .done
        return field
    }()

    lazy var confirmPasswordField: UITextField = {
        let field = LoginTextField("Confirm new password", isSecure: true, isEmail: false)
        field.delegate = self as UITextFieldDelegate
        field.translatesAutoresizingMaskIntoConstraints = false
        field.returnKeyType = .done
        return field
    }()

    lazy var submitButton: UIButton = {
        let button = TransparentButton("Submit")
        button.isEnabled = false
        return button
    }()

    // MARK: - Custom Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        currentEmail.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        currentEmail.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        currentEmailField.topAnchor.constraint(equalTo: currentEmail.bottomAnchor).isActive = true
        currentEmailField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        currentEmailField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        currentPasswordLabel.topAnchor.constraint(
            equalTo: currentEmailField.bottomAnchor,
            constant: ChangePasswordViewController.fieldSpacing).isActive = true
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
        view.addSubview(currentEmail)
        view.addSubview(currentEmailField)
        view.addSubview(currentPasswordLabel)
        view.addSubview(newPasswordLabel)
        view.addSubview(confirmPasswordLabel)
        view.addSubview(currentPasswordField)
        view.addSubview(newPasswordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(submitButton)
    }

    func passwordChangeFailed() {
        let alertTitle = "Error"
        let alertText = "Unsuccessful password change"
        let alertVC = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    func passwordSuccess() {
        let alertTitle = "Success"
        let alertText = "Password changed successfully"
        let alertVC = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
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
            confirmPasswordField.text == newPasswordField.text &&
            currentEmailField.text != nil && currentEmailField.text != ""
    }

    @objc
    func submit() {
        print("Change password")

        guard let emailText = currentEmailField.text else {
            return
        }
        guard let oldPasswordText = currentPasswordField.text else {
            return
        }
        guard let newPasswordText = newPasswordField.text else {
            return
        }

        // First, check user's provider
        let user = Auth.auth().currentUser
        let provider = Auth.auth().currentUser?.providerData[0].providerID
        let credential = EmailAuthProvider.credential(withEmail: emailText,
                                                      password: oldPasswordText)

        if provider != "password" {
            let alertTitle = "Error"
            let alertText = "Password cannot be changed for accounts associated with Google and Facebook"
            let alertVC = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }

        // Prompt the user to re-provide their sign-in credentials
        user?.reauthenticate(with: credential) { _, error in
            if error != nil {
                print("Password change unsuccessful")
                self.passwordChangeFailed()
                return
            } else {
                // User re-authenticated.
            }
        }

        // Update password
        Auth.auth().currentUser?.updatePassword(to: newPasswordText) { _ /* error */ in
            print("Password change unsuccessful")
            self.passwordChangeFailed()
            return
        }

        // Communicate to user that password change was successful
        print("Password was successfully changed")
        passwordSuccess()

        currentEmailField.text = ""
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
        currentEmailField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        currentPasswordField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        newPasswordField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        confirmPasswordField.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }

}
