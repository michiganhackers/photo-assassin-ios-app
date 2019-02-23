//
//  LoginScreenViewController
//  
//
//  Created by Thomas Smith on 2/21/19.
//

import UIKit

class LoginScreenViewController: UIViewController {
    let textfieldOffset: CGFloat = 70.0
    let textfieldSeparation: CGFloat = 30.0
    let loginButtonOffset: CGFloat = 100.0

    lazy var appTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Photo Assassin"
        label.textColor = Colors.text
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.headline)
        label.font = UIFont(descriptor: descriptor, size: 36.0)
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
        gradient.frame = view.bounds
        return gradient
    }()

    func addSubviews() {
        view.addSubview(appTitle)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide

        appTitle.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        appTitle.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true

        emailField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        emailField.bottomAnchor.constraint(equalTo: margins.centerYAnchor,
            constant: -textfieldSeparation / 2.0 - textfieldOffset).isActive = true
        emailField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        passwordField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo: margins.centerYAnchor,
                    constant: textfieldSeparation / 2 - textfieldOffset).isActive = true
        passwordField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

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
