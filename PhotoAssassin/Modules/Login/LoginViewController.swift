//
//  LoginViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 2/28/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import UIKit

class LoginViewController: LoginRegisterViewController, GIDSignInDelegate {
    // MARK: - Text and Number Class Constants
    let linkSpacing: CGFloat = 10.0
    let logoSpacing: CGFloat = 20.0
    let maxLogoSizeMultiplier: CGFloat = 0.5
    let socialMediaButtonHeight: CGFloat = 80.0
    let socialMediaSpace: CGFloat = 20.0
    let sizeOfText: CGFloat = 15.0

    // MARK: - UI Elements
    lazy var forgotPasswordLink: UIButton = {
        let link = TransitionLinkButton("Forgot Password?")
        link.translatesAutoresizingMaskIntoConstraints = false
        link.addTarget(self, action: #selector(forgotPasswordLinkTapped), for: .touchUpInside)
        return link
    }()

    lazy var registerLink: UIButton = {
        let link = TransitionLinkButton("Register")
        link.translatesAutoresizingMaskIntoConstraints = false
        link.addTarget(self, action: #selector(registerLinkTapped), for: .touchUpInside)
        return link
    }()

    lazy var googleRegisterButton: UIButton = {
        var button: UIButton
        if let image = R.image.googleLogo() {
            button = SocialMediaLoginButton("continue \nwith google",
                                            height: socialMediaButtonHeight, textSize: sizeOfText, image: image)
        } else {
            button = UIButton()
            button.setTitle("continue \nwith google", for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(googleLoginTapped), for: .touchUpInside)
        return button
    }()

    lazy var facebookRegisterButton: UIButton = {
        var button: UIButton
        if let image = R.image.facebookLogo() {
            button = SocialMediaLoginButton("continue with facebook",
                                            height: socialMediaButtonHeight, textSize: sizeOfText, image: image)
        } else {
            button = UIButton()
            button.setTitle("continue with facebook", for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(facebookLoginTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Overrides
    override func addSubviews() {
        super.addSubviews()
        contentView.addSubview(googleRegisterButton)
        contentView.addSubview(facebookRegisterButton)
        contentView.addSubview(forgotPasswordLink)
        contentView.addSubview(registerLink)
    }

    override func setUpConstraints() {
        super.setUpConstraints()

        let margins = contentView.layoutMarginsGuide

        loginRegisterButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor,
                                                 constant: loginButtonOffset).isActive = true
        loginRegisterButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        loginRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        googleRegisterButton.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor,
                                                  constant: socialMediaSpace).isActive = true
        googleRegisterButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        googleRegisterButton.widthAnchor.constraint(equalTo: margins.widthAnchor,
                                                    constant: -(self.view.bounds.width / 2) - 10).isActive = true
        //googleRegisterButton.heightAnchor.constraint(equalTo: loginRegisterButton.heightAnchor,
        //       constant: 50).isActive = true

        facebookRegisterButton.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor,
                                                    constant: socialMediaSpace).isActive = true
        facebookRegisterButton.widthAnchor.constraint(equalTo: margins.widthAnchor,
                                                      constant: -(self.view.bounds.width / 2) - 10).isActive = true
        facebookRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        //facebookRegisterButton.heightAnchor.constraint(
        //   equalTo: loginRegisterButton.heightAnchor, constant: 50).isActive = true

        forgotPasswordLink.topAnchor.constraint(
            equalTo: googleRegisterButton.bottomAnchor,
            constant: linkSpacing).isActive = true
        forgotPasswordLink.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        //forgotPasswordLink.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -50.0).isActive = true
        registerLink.topAnchor.constraint(
            equalTo: googleRegisterButton.bottomAnchor,
            constant: linkSpacing).isActive = true
        registerLink.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        //registerLink.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -50.0).isActive = true
    }

    override func getBottomSubview() -> UIView {
        return forgotPasswordLink
    }

    override func getSpaceAboveTitle() -> CGFloat {
        return 40.0
    }

    override func getSpaceBelowTitle() -> CGFloat {
        return 60.0
    }

    override func getTextFieldSeparation() -> CGFloat {
        return 12.0
    }

    // MARK: - Custom Functions

    // Handle errors
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error signing in \(error)")
        }
    }

    func loginFailed() {
        let alertTitle = "Error"
        let alertText = "Login failed"
        let alertVC = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    // MARK: - Event Listeners
    @objc
    func registerLinkTapped() {
        routeTo(screen: .setupProfile)
    }

    @objc
    func forgotPasswordLinkTapped() {
        routeTo(screen: .forgotPassword)
    }

    @objc
    func facebookLoginTapped() {
        print("Attempted Facebook registration")
        let loginManager = LoginManager()

        // Log out
        if let currentAccessToken = AccessToken.current, currentAccessToken.appID != Settings.appID {
            loginManager.logOut()
        }

        // Log in
        loginManager.logIn(permissions: [ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
                self.loginFailed()
            case .cancelled:
                print("User cancelled login.")
            case .success(_ /* grantedPermissions */, _ /* declinedPermissions */, _ /* accessToken */):
                print("Logged in!")
                guard let accessToken = AccessToken.current else {
                    print("Failed to get access token")
                    return
                }
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                Auth.auth().signIn(with: credential) { _ /* authResult */, error in
                    if let error = error {
                        print("Login error: \(error.localizedDescription)")
                        self.loginFailed()
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
    func googleLoginTapped() {
        print("Attempted Google login")
        //GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(
            buttonText: "Log In",
            screenTitle: "Photo Assassin", titleSize: 90) { (_ email: String, _ password: String) -> Void in
                // Ignored
        }
        self.onButtonTap = { (_ email: String, _ password: String) in
            Auth.auth().signIn(withEmail: email, password: password) { _ /* user */, _ /* error */ in
                self.routeTo(screen: .camera)
            }
        }
    }
}
