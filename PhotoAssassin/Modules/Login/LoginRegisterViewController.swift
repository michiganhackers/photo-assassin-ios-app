//
//  LoginRegisterViewController
//  Created by Thomas Smith on 2/21/19.
//
//  This file contains the generic ViewController prototype for both the login
//  and registration screens that are presented to the user on start up if the
//  user is not logged in.

import UIKit

class LoginRegisterViewController: UIViewController {
    // MARK: - Text and Number Class Constants
    let titleSize: CGFloat = 52.0
    let textfieldSeparation: CGFloat = 30.0
    let loginButtonOffset: CGFloat = 100.0
    let loginButtonHeight: CGFloat = 67.0
    let buttonText: String
    let onButtonTap: (_ email: String, _ password: String) -> Void

    // MARK: - UI Elements
    lazy var appTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Photo Assassin"
        label.textAlignment = .center
        label.textColor = Colors.text
        label.font = R.font.economicaBold(size: titleSize)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var emailField: UITextField = {
        let field = LoginTextField("email", isSecure: false, isEmail: true)
        field.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        return field
    }()
    lazy var passwordField: UITextField = {
        let field = LoginTextField("password", isSecure: true, isEmail: false)
        field.addTarget(self, action: #selector(fieldEdited), for: .editingChanged)
        return field
    }()

    lazy var loginRegisterButton: UIButton = {
        let button = LoginRegisterButton(buttonText, height: loginButtonHeight)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginRegisterButtonTapped), for: .touchDown)
        return button
    }()

    lazy var backgroundGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            Colors.startBackgroundGradient.cgColor,
            Colors.endBackgroundGradient.cgColor
        ]
        return gradient
    }()

    // MARK: - Set Up Functions
    func addSubviews() {
        view.addSubview(appTitle)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginRegisterButton)
        view.layer.insertSublayer(backgroundGradient, at: 0)
        view.backgroundColor = Colors.behindGradient
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide

        appTitle.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor,
                                        multiplier: 1.0).isActive = true
        appTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        NSLayoutConstraint(item: appTitle, attribute: .top, relatedBy: .equal,
               toItem: margins, attribute: .bottom, multiplier: 0.2,
               constant: -50.0).isActive = true

        emailField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        emailField.bottomAnchor.constraint(equalTo: margins.centerYAnchor,
            constant: -textfieldSeparation / 2.0).isActive = true
        emailField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        passwordField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo: margins.centerYAnchor,
                    constant: textfieldSeparation / 2).isActive = true
        passwordField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        loginRegisterButton.topAnchor.constraint(equalTo: margins.centerYAnchor,
                                         constant: loginButtonOffset).isActive = true
        loginRegisterButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        loginRegisterButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        setUpConstraints()
        backgroundGradient.frame = view.bounds
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }

    // MARK: - Event Handlers
    @objc
    func loginRegisterButtonTapped() {
        onButtonTap(emailField.text ?? "", passwordField.text ?? "")
    }

    @objc
    func fieldEdited() {
        loginRegisterButton.isEnabled = emailField.text != "" && passwordField.text != ""
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        self.buttonText = "Button"
        self.onButtonTap = { _, _ in }
        super.init(coder: aDecoder)
    }
    init(buttonText: String, onButtonTap: @escaping (_ email: String, _ password: String) -> Void) {
        self.buttonText = buttonText
        self.onButtonTap = onButtonTap
        super.init(nibName: nil, bundle: nil)
    }
}
