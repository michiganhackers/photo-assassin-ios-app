//
//  LoginScreenViewController
//  
//
//  Created by Thomas Smith on 2/21/19.
//

import UIKit

class LoginScreenViewController: UIViewController {
    let titleSize: CGFloat = 56.0
    let textfieldSeparation: CGFloat = 30.0
    let loginButtonOffset: CGFloat = 100.0

    lazy var appTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Photo Assassin"
        label.textAlignment = .center
        label.textColor = Colors.text
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.headline)
        label.font = UIFont(descriptor: descriptor, size: titleSize)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let emailField: UITextField = LoginTextField("email", isSecure: false, isEmail: true)
    let passwordField: UITextField = LoginTextField("password", isSecure: true, isEmail: false)

    lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(Colors.text, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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

    func addSubviews() {
        view.addSubview(appTitle)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
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

        loginButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: margins.centerYAnchor,
                                         constant: loginButtonOffset).isActive = true
    }

    override func viewWillLayoutSubviews() {
        setUpConstraints()
        backgroundGradient.frame = view.bounds
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
}
