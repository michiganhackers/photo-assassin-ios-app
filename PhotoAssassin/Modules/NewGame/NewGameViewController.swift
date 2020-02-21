//
//  NewGameViewController.swift
//  PhotoAssassin
//
//  Created by Anna on 2019/4/4.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class NewGameViewController: NavigatingViewController, UITextFieldDelegate {
    // MARK: - Class Constants
    let mainTextSize: CGFloat = 36.0
    let verticalSpacing: CGFloat = 30.0
    let backend = BackendCaller()
    // MARK: - UI Elements
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.attributedText = NSAttributedString(string: "Title",
            attributes: [
                .foregroundColor: Colors.seeThroughText,
                .font: R.font.economicaBold.orDefault(size: mainTextSize)
            ]
        )
        return titleLabel
    }()

    lazy var titleTextField: UITextField = {
        let titleText = UserEnterTextField("")
//        titleText.delegate = self
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.returnKeyType = .done
        return titleText
    }()
    lazy var playerLimit: UILabel = {
        let playerLimit = UILabel()
        playerLimit.translatesAutoresizingMaskIntoConstraints = false
        playerLimit.attributedText = NSAttributedString(string: "Player Limit",
            attributes: [
                .foregroundColor: Colors.seeThroughText,
                .font: R.font.economicaBold.orDefault(size: mainTextSize)
            ]
        )
        return playerLimit
    }()
    lazy var playerLimitTextField: UITextField = {
        let playerNumber = UserEnterTextField("", height: 45)
        playerNumber.delegate = self
        playerNumber.returnKeyType = .done
        playerNumber.translatesAutoresizingMaskIntoConstraints = false
        playerNumber.keyboardType = .numberPad
        return playerNumber
    }()
    lazy var invitePlayersButton: UIButton = {
        let button = TransparentButton("Invite Players")
        button.addTarget(self, action: #selector(invitePlayersButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var createButton: UIButton = {
        let button = TranslucentButton("Create Game")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(bringToCreate), for: .touchUpInside)
        return button
    }()

    var invitedPlayers: Set<String> = Set<String>()

    // MARK: - Nested Types
    enum GameStartTime {
        case tenMinutes
        case thirtyMinutes
        case oneHour
    }

    // MARK: - Custom Functions
    @objc
    func bringToCreate() {
        guard let text: String = playerLimitTextField.text, let playerCount = Int(text), playerCount >= 3 else {
                let alertTitle = " Error "
                let alertText  = " Have to be at least 3 Players "
                let alertVC = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            return
                }
        guard let name = titleTextField.text, name != "" else {
            let alertTitle = " Error "
            let alertText = " Please Type a Valid Game Title "
            let alertVC = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            return
        }
            let invitedPlayersList = Array(invitedPlayers)
            backend.createGame(name: name, invitedUsernames: invitedPlayersList,
                               maxPlayers: playerCount) { result, error in
                if let actualError = error {
                    print("Encountered error when creating game:\n\(actualError)")
                    let alertTitle = " Error "
                    let alertText  = " could not create game, try again later "
                    let alertVC = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
                guard let gameID = result else {
                    print("No gameID passed back but game creation seemed succesful")
                    self.pop()
                    return
                }
                print("Successful game creation with gameID \(gameID)")
                self.pop()
            }
            invitedPlayers = Set<String>()
            titleTextField.text = ""
    }
    @objc
    func invitePlayersButtonTapped() {
        if let nav = navigationController {
            let vcToPush = InvitePlayersViewController(alreadyInvited: invitedPlayers) { usernames in
                self.invitedPlayers = usernames
            }
            nav.pushViewController(vcToPush, animated: true)
        }
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        playerLimit.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        playerLimit.topAnchor.constraint(equalTo: titleTextField.bottomAnchor,
                                          constant: verticalSpacing).isActive = true
        playerLimitTextField.leftAnchor.constraint(equalTo: playerLimit.rightAnchor).isActive = true
        playerLimitTextField.widthAnchor.constraint(equalToConstant: 81).isActive = true
        playerLimitTextField.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        playerLimitTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor,
                                           constant: verticalSpacing).isActive = true
        invitePlayersButton.topAnchor.constraint(equalTo: playerLimit.bottomAnchor,
            constant: verticalSpacing).isActive = true
        invitePlayersButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        invitePlayersButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        createButton.topAnchor.constraint(equalTo: invitePlayersButton.bottomAnchor,
                                                 constant: verticalSpacing).isActive = true
        createButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        createButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(invitePlayersButton)
        view.addSubview(createButton)
        view.addSubview(playerLimit)
        view.addSubview(playerLimitTextField)
    }
       // MARK: - Picker View
    enum ValidationError: Error {
            case moreThanFifty(String)
    }
    func errorCatch () throws {
        throw ValidationError.moreThanFifty("Too Many Players")
    }
    func textField(textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
      guard !string.isEmpty else {
          return true
      }
        if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
          return true
       } else {
          return false
       }
    }
    func textFieldShouldReturn( _ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(title: "New Game")
    }
}
