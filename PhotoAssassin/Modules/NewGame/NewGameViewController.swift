//
//  NewGameViewController.swift
//  PhotoAssassin
//
//  Created by Anna on 2019/4/4.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class NewGameViewController: NavigatingViewController, UITextFieldDelegate {
    // MARK: - String and Number Constants
    let pickerButtonSpacing: CGFloat = 10.0
    let mainTextSize: CGFloat = 36.0

    // MARK: - UI Elements
    lazy var createButton: UIButton = {
        let button = TranslucentButton("Create")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(bringToCreate), for: .touchUpInside)
        return button
    }()

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

    lazy var addPlayerLabel: UILabel = {
        let addPlayerLabel = UILabel()
        addPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
        addPlayerLabel.attributedText = NSAttributedString(
            string: "Added Players",
            attributes: [
                .foregroundColor: Colors.seeThroughText,
                .font: R.font.economicaBold.orDefault(size: mainTextSize)
            ]
        )
        return addPlayerLabel
    }()

    lazy var titleTextField: UITextField = {
        let titleText = UserEnterTextField("")
        titleText.delegate = self
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.returnKeyType = .done
        return titleText
    }()

    lazy var addPlayerButton: UIButton = {
        let button = UIButton()
        let textSize: CGFloat = 72.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(
            NSAttributedString(
                string: "+",
                attributes: [
                    .foregroundColor: Colors.seeThroughText,
                    .font: R.font.economicaRegular.orDefault(size: textSize),
                    .baselineOffset: textSize - mainTextSize
                ]
            ),
            for: .normal
        )
        button.addTarget(self, action: #selector(addPlayerButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var pickerButton: PickerButton<GameStartTime> = {
        let button = PickerButton<GameStartTime>(
            options: [
                ("Start game in 10 min", .tenMinutes),
                ("Start game in 30 min", .thirtyMinutes),
                ("Start game in 1 hour", .oneHour)
            ],
            defaultRow: 1
        )
        button.addTarget(self, action: #selector(pickerButtonTapped), for: .touchUpInside)
        return button
    }()

    let addPlayerVC = AddPlayerViewController()

    let playerList = NewGamePlayerListViewController(
        players: [
            (Player(username: "benjamincarney", name: "Ben", relationship: .none, bio: "Ben's bio"), .playing),
            (Player(username: "phoebe", name: "Phoebe", relationship: .friend, bio: "Phoebe's bio"), .notPlaying),
            (Player(username: "casper-h", name: "Casper", relationship: .friend, bio: "Casper's bio"), .invited)
        ]
    )

    // MARK: - Nested Types
    enum GameStartTime {
        case tenMinutes
        case thirtyMinutes
        case oneHour
    }

    // MARK: - Custom Functions
    @objc
    func bringToCreate() {
        print("TODO: Create a new game")
    }

    @objc
    func addPlayerButtonTapped() {
        addPlayerVC.modalTransitionStyle = .coverVertical
        addPlayerVC.modalPresentationStyle = .overFullScreen
        present(addPlayerVC, animated: true, completion: nil)
    }

    @objc
    func pickerButtonTapped() {
        pickerButton.displayPickerPopover(from: self)
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        createButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10).isActive = true
        createButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(equalTo: margins.widthAnchor,
                                            multiplier: 1.0 / 3.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: margins.widthAnchor,
                                            multiplier: 1.0).isActive = true

        pickerButton.topAnchor.constraint(
            equalTo: titleTextField.bottomAnchor,
            constant: pickerButtonSpacing).isActive = true
        pickerButton.leftAnchor.constraint(
            equalTo: margins.leftAnchor).isActive = true
        pickerButton.rightAnchor.constraint(
            equalTo: margins.rightAnchor).isActive = true

        addPlayerLabel.topAnchor.constraint(
            equalTo: pickerButton.bottomAnchor,
            constant: pickerButtonSpacing).isActive = true
        addPlayerLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true

        addPlayerButton.topAnchor.constraint(
            equalTo: pickerButton.bottomAnchor,
            constant: pickerButtonSpacing).isActive = true
        addPlayerButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true

        playerList.view.topAnchor.constraint(
            equalTo: addPlayerLabel.bottomAnchor
        ).isActive = true
        playerList.view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        playerList.view.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        playerList.view.bottomAnchor.constraint(equalTo: createButton.topAnchor).isActive = true
    }

    func addSubviews() {
        view.addSubview(createButton)
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(pickerButton)
        view.addSubview(addPlayerLabel)
        view.addSubview(addPlayerButton)
        view.addSubview(playerList.view)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
