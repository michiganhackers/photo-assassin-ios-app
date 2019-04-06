//
//  NewGameViewController.swift
//  PhotoAssassin
//
//  Created by Anna on 2019/4/4.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class NewGameViewController: NavigatingViewController {
    // MARK: - String and number constants
    let pickerButtonSpacing: CGFloat = 10.0

    // MARK: - UI elements
    lazy var createButton: UIButton = {
        let gameButton = TranslucentButton("Create")
        gameButton.translatesAutoresizingMaskIntoConstraints = false
        gameButton.addTarget(self, action: #selector(bringToCreate), for: .touchUpInside)
        return gameButton
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.attributedText = NSAttributedString(string: "Title",
        attributes: [NSAttributedString.Key.foregroundColor: Colors.seeThroughText,
                     NSAttributedString.Key.font: R.font.economicaBold.orDefault(size: 36.0)])
        return titleLabel
    }()

    lazy var addPlayerLabel: UILabel = {
        let addPlayerLabel = UILabel()
        addPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
        addPlayerLabel.attributedText = NSAttributedString(string: "Added Players",
        attributes: [.foregroundColor: Colors.seeThroughText,
                     .font: R.font.economicaBold.orDefault(size: 36.0)])
        return addPlayerLabel
    }()

    lazy var titleTextField: UITextField = {
        let titleText = UserEnterTextField("")
        titleText.translatesAutoresizingMaskIntoConstraints = false
        return titleText
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
        button.addTarget(self, action: #selector(onPickerButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - Nested types
    enum GameStartTime {
        case tenMinutes
        case thirtyMinutes
        case oneHour
    }

    // MARK: - Custom functions
    @objc
    func bringToCreate() {
        print("TODO: Create a new game")
    }

    @objc
    func onPickerButtonTapped() {
        pickerButton.displayPickerPopover(from: self)
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        createButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
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
    }

    func addSubviews() {
        view.addSubview(createButton)
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(addPlayerLabel)
        view.addSubview(pickerButton)
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
