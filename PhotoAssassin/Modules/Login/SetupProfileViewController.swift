//
//  SetupProfileViewController.swift
//  PhotoAssassin
//
//  Created by Edward Huang on 23/7/2019.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import FirebaseAuth
import UIKit

// MARK: - Global Variables
var userFullName = ""

class SetupProfileViewController: ScrollingViewController {
    // MARK: - Text and Number Class Constants
    let screenTitle = "Registration"
    let titleSize: CGFloat = 100.0
    let backgroundGradient = BackgroundGradient()
    let spaceAboveTitle: CGFloat = 40.0
    let spaceBelowTitle: CGFloat = 15.0
    let continueHeight: CGFloat = 67.0
    let buttonSpacing: CGFloat = 35.0
    let spacingFromBottom: CGFloat = 10
    
    // MARK: - UI Elements
    lazy var appTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = screenTitle
        label.textAlignment = .center
        label.textColor = Colors.text
        label.font = R.font.economicaBold(size: titleSize)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var profilePicButton: UIView = {
        let button = UIButton()
        button.setImage(UIImage(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        //let imageView =
    }()
    
    lazy var continueButton: UIButton = {
        let button = LoginRegisterButton("Continue", height: continueHeight)
        button.isEnabled = false
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var nameField: UITextField = {
        let field = LoginTextField("Full Name", isSecure: false, isEmail: false)
        field.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        return field
    }()
    
    lazy var accountLink: UIButton = {
        let button = TransitionLinkButton("Have an account? Log in")
        button.addTarget(self, action: #selector(hasAccountTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Custom Functions
    func addSubviews() {
        contentView.addSubview(appTitle)
        contentView.addSubview(profilePicButton)
        contentView.addSubview(nameField)
        contentView.addSubview(continueButton)
        contentView.addSubview(accountLink)
        backgroundGradient.addToView(view)
    }
    
    func setUpConstraints() {
        let margins = contentView.layoutMarginsGuide
        /*
        appTitle.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor).isActive = true
        appTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        appTitle.topAnchor.constraint(equalTo: margins.topAnchor,
                                      constant: spaceAboveTitle).isActive = true
        appTitle.bottomAnchor.constraint(lessThanOrEqualTo: emailField.topAnchor,
                                         constant: -spaceBelowTitle).isActive = true
        
        emailField.bottomAnchor.constraint(equalTo: resetPasswordButton.topAnchor,
                                           constant: -buttonSpacing).isActive = true
        emailField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        emailField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        
        resetPasswordButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor,
                                                    constant: -buttonSpacing).isActive = true
        resetPasswordButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        resetPasswordButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        
        loginButton.bottomAnchor.constraint(equalTo: noAccountLink.topAnchor,
                                            constant: -buttonSpacing).isActive = true
        loginButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        loginButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        
        noAccountLink.bottomAnchor.constraint(equalTo: margins.bottomAnchor,
                                              constant: -spacingFromBottom).isActive = true
        noAccountLink.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        noAccountLink.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
 */
    }
    
    // MARK: - Event Listeners
    @objc
    func fieldEdited() {
        continueButton.isEnabled = nameField.text != ""
    }

    @objc
    func hasAccountTapped() {
        routeTo(screen: .login)
    }
    
    @objc
    func continueTapped() {
        userFullName = nameField.text ?? ""
        routeTo(screen: .register)
    }
    
    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
        backgroundGradient.layoutInView(view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
}
