//
//  LoginRegisterViewController
//  Created by Thomas Smith on 2/21/19.
//
//  This file contains the generic ViewController prototype for both the login
//  and registration screens that are presented to the user on start up if the
//  user is not logged in.

import UIKit

class LoginRegisterViewController: RoutedViewController {
    // MARK: - Text and Number Class Constants
    let titleOffset: CGFloat = 30.0
    let titleSize: CGFloat = 52.0
    let textFieldSeparation: CGFloat = 16.0
    let loginButtonOffset: CGFloat = 33.0
    let loginButtonHeight: CGFloat = 67.0
    let buttonText: String
    let onButtonTap: (_ email: String, _ password: String) -> Void
    let screenTitle: String

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
        label.text = screenTitle
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
        button.addTarget(self, action: #selector(loginRegisterButtonTapped), for: .touchUpInside)
        return button
    }()

    let backgroundGradient = BackgroundGradient()

    // MARK: - Custom Functions
    func shouldEnableSignIn() -> Bool {
        return emailField.text != "" && passwordField.text != ""
    }

    func getBottomSubview() -> UIView {
        return passwordField
    }

    func getTextFieldSeparation() -> CGFloat {
        return textFieldSeparation
    }

    // MARK: - Set Up Functions
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(appTitle)
        contentView.addSubview(emailField)
        contentView.addSubview(passwordField)
        contentView.addSubview(loginRegisterButton)
        backgroundGradient.addToView(view)
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

        appTitle.topAnchor.constraint(equalTo: margins.topAnchor,
                                      constant: titleOffset).isActive = true
        appTitle.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor,
                                        multiplier: 1.0).isActive = true
        appTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true

        emailField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        NSLayoutConstraint(item: emailField, attribute: .top, relatedBy: .equal,
                           toItem: appTitle, attribute: .bottom, multiplier: 1.25,
                           constant: 0.0).isActive = true
        emailField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        passwordField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor,
                                           constant: getTextFieldSeparation()).isActive = true
        passwordField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        getBottomSubview().bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
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
        self.screenTitle = "Title"
        super.init(coder: aDecoder)
    }
    init(buttonText: String,
         screenTitle: String,
         onButtonTap: @escaping (_ email: String, _ password: String) -> Void) {
        self.buttonText = buttonText
        self.onButtonTap = onButtonTap
        self.screenTitle = screenTitle
        super.init(nibName: nil, bundle: nil)
    }
}
