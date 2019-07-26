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
var userProfileImage = UIImage()

class SetupProfileViewController: ScrollingViewController, UITextViewDelegate {
    // MARK: - Text and Number Class Constants
    let screenTitle = "Registration"
    let titleSize: CGFloat = 64.0
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
        button.setImage(R.image.addPhotoIcon(), for: .normal)
        button.tintColor = UIColor.clear
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let cameraView = UILabel(frame: .zero)
        cameraView.addSubview(button)
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        
        let finalButton = UIButton()
        finalButton.setBackgroundImage(R.image.profileLogo(), for: .normal)
        finalButton.translatesAutoresizingMaskIntoConstraints = false
        finalButton.addSubview(cameraView)
        cameraView.topAnchor.constraint(equalTo: finalButton.topAnchor).isActive = true
        cameraView.rightAnchor.constraint(equalTo: finalButton.rightAnchor).isActive = true
        return finalButton
    }()
    
    lazy var nameField: UITextField = {
        let field = LoginTextField("Full Name", isSecure: false, isEmail: false)
        field.delegate = self as? UITextFieldDelegate
        field.translatesAutoresizingMaskIntoConstraints = false
        field.returnKeyType = .done
        field.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        return field
    }()
    
    lazy var continueButton: UIButton = {
        let button = LoginRegisterButton("Continue", height: continueHeight)
        button.isEnabled = false
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var accountLink: UIButton = {
        let button = TransitionLinkButton("Have an account? Log in")
        button.addTarget(self, action: #selector(hasAccountTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Custom Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
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
        
        appTitle.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor).isActive = true
        appTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        appTitle.topAnchor.constraint(equalTo: margins.topAnchor,
                                      constant: spaceAboveTitle).isActive = true
        appTitle.bottomAnchor.constraint(lessThanOrEqualTo: profilePicButton.topAnchor,
                                         constant: -spaceBelowTitle).isActive = true
        
        profilePicButton.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor).isActive = true
        profilePicButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        profilePicButton.bottomAnchor.constraint(lessThanOrEqualTo: nameField.topAnchor,
                                         constant: -spaceBelowTitle).isActive = true
        
        nameField.bottomAnchor.constraint(equalTo: continueButton.topAnchor,
                                                    constant: -buttonSpacing).isActive = true
        nameField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        nameField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        
        continueButton.bottomAnchor.constraint(equalTo: accountLink.topAnchor,
                                            constant: -buttonSpacing).isActive = true
        continueButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        continueButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        
        accountLink.bottomAnchor.constraint(equalTo: margins.bottomAnchor,
                                              constant: -spacingFromBottom).isActive = true
        accountLink.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        accountLink.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
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
        //userProfileImage = profilePicButton
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
