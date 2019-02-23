//
//  LoginScreenViewController
//  
//
//  Created by Thomas Smith on 2/21/19.
//

import UIKit

class LoginScreenViewController: UIViewController {
    let textfieldSeparation: CGFloat = 50.0
    let textfieldOffset: CGFloat = 150.0
    let loginButtonOffset: CGFloat = 100.0
    let borderWidth: CGFloat = 1.5

    lazy var appTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Photo Assassin"
        label.textColor = Colors.text
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.headline)
        label.font = UIFont(descriptor: descriptor, size: 36.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var usernameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Username"
        label.textColor = Colors.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var usernameField: UITextField = {
        let field = UITextField(frame: .zero)
        field.backgroundColor = Colors.seeThroughContrast
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    lazy var passwordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Password"
        label.textColor = Colors.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var passwordField: UITextField = {
        let field = UITextField(frame: .zero)
        field.backgroundColor = Colors.seeThroughContrast
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

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
        gradient.frame = view.bounds
        return gradient
    }()

    func addSubviews() {
        view.addSubview(appTitle)
        view.addSubview(usernameLabel)
        view.addSubview(usernameField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        appTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        appTitle.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true

        usernameLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: margins.centerYAnchor,
            constant: -textfieldSeparation / 2.0 - textfieldOffset).isActive = true

        usernameField.leftAnchor.constraint(equalTo: usernameLabel.rightAnchor,
                                            constant: 0.0).isActive = true
        usernameField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        usernameField.topAnchor.constraint(equalTo: usernameLabel.topAnchor).isActive = true

        passwordLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: margins.centerYAnchor,
                    constant: textfieldSeparation / 2 - textfieldOffset).isActive = true

        passwordField.leftAnchor.constraint(equalTo: passwordLabel.rightAnchor,
                                            constant: 0.0).isActive = true
        passwordField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo: passwordLabel.topAnchor).isActive = true

        loginButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: margins.centerYAnchor,
                                         constant: loginButtonOffset).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpConstraints()
        view.backgroundColor = Colors.behindGradient
        view.layer.insertSublayer(backgroundGradient, at: 0)
    }
}
