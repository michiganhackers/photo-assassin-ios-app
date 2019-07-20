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
import FirebaseAuth
import GoogleSignIn
import UIKit

class RegisterViewController: LoginRegisterViewController, GIDSignInUIDelegate {
    // MARK: - Text and Number Class Constants
    let linkSpacing: CGFloat = 10.0
    let socialMediaButtonHeight: CGFloat = 50.0
    let socialMediaSpace: CGFloat = 20.0

    // MARK: - UI Elements
    lazy var confirmPasswordField: UITextField = {
        let field = LoginTextField("confirm password", isSecure: true, isEmail: false)
        field.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        return field
    }()

    lazy var haveAnAccountLink: UIButton = {
        let button = TransitionLinkButton("Have an account?")
        button.addTarget(self, action: #selector(haveAnAccountTapped), for: .touchUpInside)
        return button
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
        button.addTarget(self, action: #selector(googleRegisterTapped), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(facebookRegisterTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Event Listeners
    @objc
    func facebookRegisterTapped() {
        print("Attempted Facebook registration")
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
    func googleRegisterTapped() {
        print("Attempted Google registration")
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        //GIDSignIn.sharedInstance().signInSilently()
    }

    @objc
    func haveAnAccountTapped() {
        routeTo(screen: .login)
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

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(buttonText: "sign up",
                   screenTitle: "Registration") { (_ email: String, _ password: String) -> Void in
            print("Attempted registration with email \(email) and password \(password)")
        }
    }
    @objc
    func user_Registration() {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { _ /* user */, error in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                print("Account Created!")
                self.routeTo(screen: .camera)
            }
        }
    }
    override func loginRegisterButtonTapped() {
        user_Registration()
    }
}
