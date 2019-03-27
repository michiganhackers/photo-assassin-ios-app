//
//  MenuViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 3/21/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class MenuViewController: RoutedViewController {
    let gameLobbyHeightRatio: CGFloat = 0.3

    let backgroundGradient = BackgroundGradient()

    let gameLobbyList = GameLobbyList()

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        gameLobbyList.view.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        gameLobbyList.view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        gameLobbyList.view.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        gameLobbyList.view.heightAnchor.constraint(
            equalTo: margins.heightAnchor, multiplier: gameLobbyHeightRatio).isActive = true
    }

    func addSubviews() {
        view.addSubview(gameLobbyList.view)
        backgroundGradient.addToView(view)
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
