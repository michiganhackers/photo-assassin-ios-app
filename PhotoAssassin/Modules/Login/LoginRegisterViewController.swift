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
    let textfieldSeparation: CGFloat = 16.0
    let loginButtonOffset: CGFloat = 100.0
    let loginButtonHeight: CGFloat = 67.0
    let buttonText: String
    let onButtonTap: (_ email: String, _ password: String) -> Void

    // MARK: - UI Elements
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

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

    // MARK: - Custom Functions
    func shouldEnableSignIn() -> Bool {
        return emailField.text != "" && passwordField.text != ""
    }

    func getBottomSubview() -> UIView {
        return passwordField
    }

    // MARK: - Set Up Functions
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(appTitle)
        contentView.addSubview(emailField)
        contentView.addSubview(passwordField)
        contentView.addSubview(loginRegisterButton)
        view.layer.insertSublayer(backgroundGradient, at: 0)
        view.backgroundColor = Colors.behindGradient
    }

    func setUpConstraints() {
        let parentMargins = view.layoutMarginsGuide
        let margins = contentView.layoutMarginsGuide

        scrollView.leftAnchor.constraint(equalTo: parentMargins.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: parentMargins.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: parentMargins.widthAnchor).isActive = true

        appTitle.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor,
                                        multiplier: 1.0).isActive = true
        appTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        NSLayoutConstraint(item: appTitle, attribute: .top, relatedBy: .equal,
               toItem: margins, attribute: .bottom, multiplier: 0.1,
               constant: 0.0).isActive = true

        emailField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        NSLayoutConstraint(item: emailField, attribute: .top, relatedBy: .equal,
                           toItem: appTitle, attribute: .bottom, multiplier: 1.25,
                           constant: 0.0).isActive = true
        emailField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        passwordField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor,
                                           constant: textfieldSeparation).isActive = true
        passwordField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        getBottomSubview().bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
        loginRegisterButton.isEnabled = shouldEnableSignIn()
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
