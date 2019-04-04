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
    let horizontalButtonSpacing: CGFloat = 12.0
    let verticalButtonSpacing: CGFloat = 18.0

    let backgroundGradient = BackgroundGradient()

    let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)

    let profileButton = UIBarButtonItem(image: R.image.profileLogo(), style: .plain, target: nil, action: nil)

    let createButton = TranslucentButton("Create")
    let historyButton = TranslucentButton("History")
    let activeGamesButton = TranslucentButton("Active Games")

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        createButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        createButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        createButton.widthAnchor.constraint(equalTo: margins.widthAnchor,
                                            multiplier: 0.5,
                                            constant: -horizontalButtonSpacing / 2.0).isActive = true
        historyButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        historyButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        historyButton.widthAnchor.constraint(equalTo: margins.widthAnchor,
                                             multiplier: 0.5,
                                             constant: -horizontalButtonSpacing / 2.0).isActive = true
        activeGamesButton.topAnchor.constraint(equalTo: createButton.bottomAnchor,
                                               constant: verticalButtonSpacing).isActive = true
        activeGamesButton.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        activeGamesButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    func addNavButtons() {
        cameraButton.tintColor = .white
        profileButton.tintColor = .white
        if let item = navigationController?.navigationBar.topItem {
            item.leftBarButtonItem = cameraButton
            item.rightBarButtonItem = profileButton
            item.title = "Main Menu"
        }
    }

    func addSubviews() {
        view.addSubview(createButton)
        view.addSubview(historyButton)
        view.addSubview(activeGamesButton)
        addNavButtons()
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
