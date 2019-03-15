//
//  RegisterViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 3/14/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class RegisterViewController: LoginRegisterViewController {
    let socialMediaButtonHeight: CGFloat = 50.0
    let haveAnAccountTextSize: CGFloat = 25.0
    let socialMediaSpace: CGFloat = 20.0

    lazy var confirmPasswordField: UITextField = {
        let field = LoginTextField("confirm password", isSecure: true, isEmail: false)
        return field
    }()

    lazy var haveAnAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.burgundy, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = R.font.economicaBold(size: haveAnAccountTextSize)
        let buttonText = NSMutableAttributedString(string: "Have an account?")
        buttonText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue,
                        range: NSRange(location: 0, length: buttonText.string.count))
        buttonText.addAttribute(.foregroundColor, value: Colors.burgundy,
                                range: NSRange(location: 0, length: buttonText.string.count))
        button.setAttributedTitle(buttonText, for: .normal)

        return button
    }()

    lazy var googleRegisterButton: UIButton = {
        var button: UIButton
        if let image = R.image.googleLogo() {
            button = SocialMediaLoginButton("continue with Google",
                                            height: socialMediaButtonHeight, image: image)
        } else {
            button = UIButton()
            button.setTitle("continue with Google", for: .normal)
        }
        return button
    }()
    
    lazy var facebookRegisterButtion: UIButton = {
        var button: UIButton
        if let image = R.image.facebookLogo() {
            button = SocialMediaLoginButton("continue with Facebook",
                                            height: socialMediaButtonHeight, image: image)
        } else {
            button = UIButton()
            button.setTitle("continue with Facebook", for: .normal)
        }
        return button
    }()

    override func addSubviews() {
        super.addSubviews()
        view.addSubview(confirmPasswordField)
        view.addSubview(haveAnAccountButton)
        view.addSubview(googleRegisterButton)
        view.addSubview(facebookRegisterButtion)
    }

    override func setUpConstraints() {
        super.setUpConstraints()

        let margins = view.layoutMarginsGuide

        confirmPasswordField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor,
                                           constant: textfieldSeparation).isActive = true
        confirmPasswordField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        loginRegisterButton.topAnchor.constraint(equalTo: confirmPasswordField.topAnchor    ,
                                                 constant: loginButtonOffset).isActive = true
        loginRegisterButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        loginRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        haveAnAccountButton.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor).isActive = true
        haveAnAccountButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true

        googleRegisterButton.topAnchor.constraint(equalTo: haveAnAccountButton.bottomAnchor, constant: socialMediaSpace).isActive = true
        googleRegisterButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        googleRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        facebookRegisterButtion.topAnchor.constraint(equalTo: googleRegisterButton.bottomAnchor, constant: socialMediaSpace).isActive = true
        facebookRegisterButtion.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        facebookRegisterButtion.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(buttonText: "sign up") { (_ email: String, _ password: String) -> Void in
            print("Attempted registration with email \(email) and password \(password)")
        }
    }
}
