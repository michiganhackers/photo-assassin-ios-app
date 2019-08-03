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

class SetupProfileViewController: ScrollingViewController, UITextFieldDelegate {
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
    
    lazy var profilePicButton: UIImageView = {
        let button = UIButton()
        button.setBackgroundImage(R.image.addPhotoIcon(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changePicture), for: .touchUpInside)
        
        let view = UIImageView()
        let tintedImage = R.image.profileLogo()?.withRenderingMode(.alwaysTemplate)
        view.image = tintedImage
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addSubview(button)
        view.topAnchor.constraint(equalTo: button.topAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: button.rightAnchor).isActive = true
        return view
    }()
    
    lazy var nameField: UITextField = {
        let field = UserEnterTextField("Full Name")
        field.delegate = self as? UITextFieldDelegate
        field.translatesAutoresizingMaskIntoConstraints = false
        field.returnKeyType = .done
        field.autocapitalizationType = .words
        field.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        return field
    }()
    
    lazy var continueButton: UIButton = {
        let button = LoginRegisterButton("Continue", height: continueHeight)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var hasAccountLink: UIButton = {
        let button = TransitionLinkButton("Have an account? Log in")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(hasAccountTapped), for: .touchUpInside)
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
        contentView.addSubview(hasAccountLink)
        backgroundGradient.addToView(view)
    }
    
    func setUpConstraints() {
        let margins = contentView.layoutMarginsGuide
        
        appTitle.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor).isActive = true
        appTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        appTitle.topAnchor.constraint(equalTo: margins.topAnchor,
                                      constant: spaceAboveTitle).isActive = true
        
        profilePicButton.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: spaceBelowTitle).isActive = true
        profilePicButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        profilePicButton.widthAnchor.constraint(equalTo: appTitle.widthAnchor, constant: -150).isActive = true
        profilePicButton.heightAnchor.constraint(equalTo: appTitle.widthAnchor, constant: -150).isActive = true
        
        nameField.topAnchor.constraint(equalTo: profilePicButton.bottomAnchor, constant: buttonSpacing).isActive = true
        nameField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        nameField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        
        continueButton.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: buttonSpacing).isActive = true
        continueButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        continueButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        
        hasAccountLink.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -spacingFromBottom).isActive = true
        hasAccountLink.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: buttonSpacing).isActive = true
        hasAccountLink.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        hasAccountLink.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }
    
    func isValidDisplayName(_ displayName: String) -> Bool {
        let regex = "(?i)^(?![- '])(?![×Þß÷þø])[- '0-9a-zÀ-ÿ]+(?<![- '])$"
        if (displayName.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil && displayName.count >= 5 && displayName.count <= 20) {
            return true
        }
        return false
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
        if (isValidDisplayName(nameField.text ?? "")) {
            print("continue tapped")
            userFullName = nameField.text ?? ""
            //userProfileImage = profilePicButton
            routeTo(screen: .register)
        } else {
            print("Not a valid display name")
            let alertTitle = "Invalid display name"
            let alertText = "Choose a display name betweeen 5 and 20 characters and that"
                + "contains only alphanumeric characters, spaces, hyphens, and apostrophes."
                + "Display name also cannot begin or end with a space, hyphen, or apostrophe"
            let alertVC = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @objc
    func changePicture() {
        print("Change picture")
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
