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
    let socialMediaButtonHeight: CGFloat = 50.0
    let socialMediaSpace: CGFloat = 20.0

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
    
    lazy var googleRegisterButton: UIButton = {
        var button: UIButton
        if let image = R.image.googleLogo() {
            button = SocialMediaLoginButton("continue with google",
                                            height: socialMediaButtonHeight, image: image)
        } else {
            button = UIButton()
            button.setTitle("continue with google", for: .normal)
        }
        button.addTarget(self, action: #selector(googleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var facebookRegisterButton: UIButton = {
        var button: UIButton
        if let image = R.image.facebookLogo() {
            button = SocialMediaLoginButton("continue with facebook",
                                            height: socialMediaButtonHeight, image: image)
        } else {
            button = UIButton()
            button.setTitle("continue with facebook", for: .normal)
        }
        button.addTarget(self, action: #selector(facebookLoginTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Overrides
    override func addSubviews() {
        super.addSubviews()
        contentView.addSubview(forgotPasswordLink)
        contentView.addSubview(registerLink)
        contentView.addSubview(assassinLogo)
        contentView.addSubview(googleRegisterButton)
        contentView.addSubview(facebookRegisterButton)
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
        
        googleRegisterButton.topAnchor.constraint(equalTo: assassinLogo.bottomAnchor,
                                                  constant: socialMediaSpace).isActive = true
        googleRegisterButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        googleRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        facebookRegisterButton.topAnchor.constraint(equalTo: googleRegisterButton.bottomAnchor,
                                                    constant: socialMediaSpace).isActive = true
        facebookRegisterButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        facebookRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    override func getBottomSubview() -> UIView {
        return facebookRegisterButton
    }

    override func getSpaceAboveTitle() -> CGFloat {
        return 40.0
    }

    override func getSpaceBelowTitle() -> CGFloat {
        return 60.0
    }

    override func getTextFieldSeparation() -> CGFloat {
        return loginButtonOffset
    }
    
    // MARK: - Google Sign-In Methods
    
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

    // MARK: - Event Listeners
    @objc
    func registerLinkTapped() {
        routeTo(screen: .register)
    }

    @objc
    func forgotPasswordLinkTapped() {
        routeTo(screen: .forgotPassword)
    }
    
    @objc
    func facebookLoginTapped() {
        print("Attempted Facebook login")
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ReadPermission.publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(_ /* let grantedPermissions */,
                _ /* let declinedPermissions */,
                _ /* let accessToken */):
                print("Logged in!")
                self.routeTo(screen: .camera)
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
            buttonText: "login",
            screenTitle: "Photo Assassin") { (_ email: String, _ password: String) -> Void in
                // Ignored
        }
        self.onButtonTap = { (_ email: String, _ password: String) in
            Auth.auth().signIn(withEmail: email, password: password) { _ /* user */, _ /* error */ in
                self.routeTo(screen: .camera)
            }
        }
    }
}
