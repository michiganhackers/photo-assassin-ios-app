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
//    let pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "10"]
    
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
        titleText.delegate = self
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
        let playerNumber = UserEnterTextField("", height: 50)
        playerNumber.delegate = self
        playerNumber.returnKeyType = .done
        playerNumber.translatesAutoresizingMaskIntoConstraints = false
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
        if let name = titleTextField.text {
            let invitedPlayersList = Array(invitedPlayers)
            print("TODO: Create game with name \(name) and invited players \(invitedPlayersList)")
            backend.createGame(name: name, invitedUsernames: invitedPlayersList) { result, error in
                if let actualError = error {
                    print("Encountered error when creating game:\n\(actualError)")
                    // TODO: Show error to user
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
    
    
    
    func textFieldShouldReturn( textField: UITextField) -> Bool {
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
