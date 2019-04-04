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

    let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)

    let profileButton = UIBarButtonItem(image: R.image.profileLogo(), style: .plain, target: nil, action: nil)

    func setUpConstraints() {
        // TODO
    }

    func addButtons() {
        cameraButton.tintColor = .white
        profileButton.tintColor = .white
        if let item = navigationController?.navigationBar.topItem {
            item.leftBarButtonItem = cameraButton
            item.rightBarButtonItem = profileButton
            item.title = "Main Menu"
        }
    }

    func addSubviews() {
        addButtons()
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
