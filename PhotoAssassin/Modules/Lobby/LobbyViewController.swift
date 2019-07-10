//
//  LobbyViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 3/28/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class LobbyViewController: RoutedViewController {

    let lobby = GameLobby(title: "Game Lobby", description: "Specific Game Lobby", numberInLobby: 3, capacity: 5)
    let lobbyTitleSize: CGFloat = 36.0
    let lobbyDescriptionSize: CGFloat = 20.0

    let backgroundGradient = BackgroundGradient()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = lobby.title
        label.font = R.font.economicaBold(size: lobbyTitleSize)
        label.textColor = Colors.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var lobbyDescription: UILabel = {
        let description = UILabel()
        description.text = lobby.description
        description.font = R.font.economicaRegular(size: lobbyDescriptionSize)
        description.textColor = Colors.text
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()

    func addSubviews() {
        backgroundGradient.addToView(view)
        view.addSubview(titleLabel)
        view.addSubview(lobbyDescription)
    }

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        lobbyDescription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        lobbyDescription.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
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
}
