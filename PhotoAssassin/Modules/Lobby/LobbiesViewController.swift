//
//  ActiveGamesViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 4/4/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class LobbiesViewController: UIViewController {

    // MARK: - Class Constants
    let topMargin: CGFloat = 40.0
    let middleMargin: CGFloat = 10.0
    let sideMargin: CGFloat = 5.0
    let backgroundGradient = BackgroundGradient()

    // MARK: - UI Elements
    lazy var submitButton: UIButton = {
        let gameButton = TranslucentButton("Submit")
        gameButton.addTarget(self, action: #selector(toSubmit), for: .touchUpInside)
        return gameButton
    }()

    lazy var titleLabel: UILabel = {
        let label = MenuNavigationTitle("Choose Game(s)")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setBackgroundImage(R.image.backButton()?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(toBack), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - UI elements
    lazy var gameLobbyList: GameList<GameLobbyListCellDetailed> = {
        let list = GameList<GameLobbyListCellDetailed> { _, _ in
            // Do nothing
        }
        list.games = [
            GameLobby(id: "0ab", title: "Game 1", numberInLobby: 3, capacity: 5),
            GameLobby(id: "1cd", title: "Another Game", numberInLobby: 8, capacity: 20),
            GameLobby(id: "2ef", title: "Game 3", numberInLobby: 4, capacity: 6),
            GameLobby(id: "3gh", title: "Jason's Game", numberInLobby: 6, capacity: 100)
        ]
        return list
    }()

    // MARK: - Custom Functions
    func addSubviews() {
        backgroundGradient.addToView(view)
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(gameLobbyList.view)
        view.addSubview(submitButton)
    }

    func setUpConstraints() {
        let margins = self.view.layoutMarginsGuide
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -50).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: middleMargin).isActive = true
        backButton.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: -5.0).isActive = true
        gameLobbyList.view.topAnchor.constraint(equalTo: backButton.bottomAnchor,
                                                constant: topMargin).isActive = true
        gameLobbyList.view.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: sideMargin).isActive = true
        gameLobbyList.view.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -sideMargin).isActive = true
        submitButton.topAnchor.constraint(equalTo: gameLobbyList.view.bottomAnchor, constant: middleMargin).isActive = true
        submitButton.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: sideMargin).isActive = true
        submitButton.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -sideMargin).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -middleMargin).isActive = true
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }

    override func viewWillLayoutSubviews() {
        //super.viewWillLayoutSubviews()
        backgroundGradient.layoutInView(view)
        setUpConstraints()
    }

    // MARK: - Action Listeners
    @objc
    func toSubmit() {
        // TODO: Submit Photo
        print("Submit button pressed")
    }

    @objc
    func toBack() {
        print("back")
        //self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
}
