//
//  MenuViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 3/21/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class MenuViewController: RoutedViewController {
    let backgroundGradient = BackgroundGradient()

    let gameLobbyList = GameLobbyList()

    func setUpConstraints() {
        // TODO
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
