//
//  RegisterViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 3/14/19.
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

class RegisterViewController: LoginRegisterViewController, GIDSignInDelegate {
    // MARK: - Text and Number Class Constants
    let linkSpacing: CGFloat = 10.0
    let socialMediaButtonHeight: CGFloat = 50.0
    let socialMediaSpace: CGFloat = 20.0
    let sizeOfText: CGFloat = 27.0

    let backend = BackendCaller()

    // MARK: - UI Elements
    lazy var confirmPasswordField: UITextField = {
        let field = LoginTextField("confirm password", isSecure: true, isEmail: false)
        field.delegate = self as UITextFieldDelegate
        field.translatesAutoresizingMaskIntoConstraints = false
        field.returnKeyType = .done
        field.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        return field
    }()

    lazy var haveAnAccountLink: UIButton = {
        let button = TransitionLinkButton("Have an account?")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(haveAnAccountTapped), for: .touchUpInside)
        return button
    }()

    lazy var googleRegisterButton: UIButton = {
        var button: UIButton
        if let image = R.image.googleLogo() {
            button = SocialMediaLoginButton("register with google",
                                            height: socialMediaButtonHeight, textSize: sizeOfText, image: image)
        } else {
            button = UIButton()
            button.setTitle("register with google", for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(googleRegisterTapped), for: .touchUpInside)
        return button
    }()

    lazy var facebookRegisterButton: UIButton = {
        var button: UIButton
        if let image = R.image.facebookLogo() {
            button = SocialMediaLoginButton("register with facebook",
                                            height: socialMediaButtonHeight, textSize: sizeOfText, image: image)
        } else {
            button = UIButton()
            button.setTitle("register with facebook", for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(facebookRegisterTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Event Listeners
    @objc
    func facebookRegisterTapped() {
        print("Attempted Facebook registration")
        let loginManager = LoginManager()

        // Log out
        if let currentAccessToken = AccessToken.current, currentAccessToken.appID != Settings.appID {
            loginManager.logOut()
        }

        // Log in
        loginManager.logIn(permissions: [.publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(_, _, _ /* let grantedPermissions, let declinedPermissions, let accessToken */):
                guard let accessToken = AccessToken.current else {
                    print("Failed to get access token")
                    return
                }

                // Register with Facebook!!
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                Auth.auth().signIn(with: credential) { _ /* authResult */, error in
                    if let error = error {
                        print("Login error: \(error.localizedDescription)")
                        return
                    }
                    // User is signed in
                    print("Logged in!")
                    self.routeTo(screen: .camera)
                }
            }
        }
    }

    @objc
    func googleRegisterTapped() {
        print("Attempted Google registration")
        // Register with Google
        GIDSignIn.sharedInstance().delegate = self
        // FIXME: GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        //GIDSignIn.sharedInstance().signInSilently()
    }

    @objc
    func haveAnAccountTapped() {
        routeTo(screen: .login)
    }

    // MARK: - Custom Functions
    //Handle errors
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error signing in \(error)")
        }
    }

    func failedRegistration() {
        let alertTitle = "Error"
        let alertText = "Registration failed"
        let alertVC = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    // MARK: - Overrides
    override func addSubviews() {
        super.addSubviews()
        contentView.addSubview(confirmPasswordField)
        contentView.addSubview(haveAnAccountLink)
        contentView.addSubview(googleRegisterButton)
        contentView.addSubview(facebookRegisterButton)
    }

    override func setUpConstraints() {
        super.setUpConstraints()

        let margins = contentView.layoutMarginsGuide

        confirmPasswordField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor,
                                           constant: getTextFieldSeparation()).isActive = true
        confirmPasswordField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        loginRegisterButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor,
                                                 constant: loginButtonOffset).isActive = true
        loginRegisterButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        loginRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        haveAnAccountLink.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor,
                                               constant: linkSpacing).isActive = true
        haveAnAccountLink.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true

        googleRegisterButton.topAnchor.constraint(equalTo: haveAnAccountLink.bottomAnchor,
                        constant: socialMediaSpace).isActive = true
        googleRegisterButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        googleRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        facebookRegisterButton.topAnchor.constraint(equalTo: googleRegisterButton.bottomAnchor,
                        constant: socialMediaSpace).isActive = true
        facebookRegisterButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        facebookRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    override func shouldEnableSignIn() -> Bool {
        return super.shouldEnableSignIn() && confirmPasswordField.text != "" &&
               confirmPasswordField.text == passwordField.text
    }

    override func getBottomSubview() -> UIView {
        return facebookRegisterButton
    }

    // Checks if input String is a valid email
    func isValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(buttonText: "sign up",
                   screenTitle: "Registration", titleSize: 64) { (_ email: String, _ password: String) -> Void in
            print("Attempted registration with email \(email) and password \(password)")
        }
    }

    @objc
    func user_Registration() {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { _ /*authResult*/, error in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    self.failedRegistration()
                    return
                }
                // Add user to the database
                self.backend.addUser(displayName: userFullName, username: userName) { result, error in
                    if let actualError = error {
                        print("Encountered error when creating game:\n\(actualError)")
                        // TODO: Show error to user
                    }
                    guard let displayName = result else {
                        print("No displayName passed back but user creation seemed successful")
                        return
                    }
                    print("Successfully added user with displayName \(displayName)")
                }
                // TODO: Update user with profile picture
                print("Account Created!")
                self.routeTo(screen: .camera)
            }
        }
    }

    override func loginRegisterButtonTapped() {
        let password = passwordField.text ?? ""
        let confirmPassword = confirmPasswordField.text ?? ""
        if isValid(emailField.text ?? "") && password.count >= 8 && password == confirmPassword {
            user_Registration()
        } else {
            let alertTitle = "Error"
            let alertText = "Email must be valid, password must be at least 8 characters, " +
                            "and password and confirm password must be the same."
            let alertVC = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
