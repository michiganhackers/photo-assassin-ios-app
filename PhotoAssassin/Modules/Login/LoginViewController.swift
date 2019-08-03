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

class LoginViewController: LoginRegisterViewController, GIDSignInUIDelegate {
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
            button = SocialMediaLoginButton("continue with google",
                                            height: socialMediaButtonHeight, textSize: sizeOfText, image: image)
        } else {
            button = UIButton()
            button.setTitle("continue with google", for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(googleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var facebookRegisterButton: UIButton = {
        var button: UIButton
        if let image = R.image.facebookLogo() {
            button = SocialMediaLoginButton("continue with facebook",
                                            height: socialMediaButtonHeight, textSize: sizeOfText,  image: image)
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
        googleRegisterButton.widthAnchor.constraint(equalTo: margins.widthAnchor, constant: -(self.view.bounds.width / 2) - 10).isActive = true
        //googleRegisterButton.heightAnchor.constraint(equalTo: loginRegisterButton.heightAnchor, constant: 50).isActive = true
        
        facebookRegisterButton.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor,
                                                    constant: socialMediaSpace).isActive = true
        facebookRegisterButton.widthAnchor.constraint(equalTo: margins.widthAnchor, constant: -(self.view.bounds.width / 2) - 10).isActive = true
        facebookRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        //facebookRegisterButton.heightAnchor.constraint(equalTo: loginRegisterButton.heightAnchor, constant: 50).isActive = true
        
        forgotPasswordLink.topAnchor.constraint(
            equalTo: googleRegisterButton.bottomAnchor,
            constant: linkSpacing).isActive = true
        forgotPasswordLink.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        
        registerLink.topAnchor.constraint(
            equalTo: googleRegisterButton.bottomAnchor,
            constant: linkSpacing).isActive = true
        registerLink.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
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
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        print("Error signing in: ", error)
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
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
        if let currentAccessToken = FBSDKAccessToken.current(), currentAccessToken.appID != FBSDKSettings.appID() {
            loginManager.logOut()
        }
        
        // Log in
        loginManager.logIn(readPermissions: [ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
                self.loginFailed()
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                guard let accessToken = FBSDKAccessToken.current() else {
                    print("Failed to get access token")
                    return
                }
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                Auth.auth().signIn(with: credential) { (authResult, error) in
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
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        //GIDSignIn.sharedInstance().signInSilently()
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(
            buttonText: "Log In",
            screenTitle: "Photo Assassin", titleSize: 100) { (_ email: String, _ password: String) -> Void in
        }
    }
}
