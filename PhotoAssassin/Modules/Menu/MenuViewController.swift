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
    
    let navigationBar = UINavigationBar()
    
    let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
    
    let profileButton = UIBarButtonItem(image: R.image.profileLogo(), style: .plain, target: nil, action: nil)

    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        navigationBar.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        navigationBar.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        gameLobbyList.view.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        gameLobbyList.view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        gameLobbyList.view.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        gameLobbyList.view.heightAnchor.constraint(
            equalTo: margins.heightAnchor, multiplier: gameLobbyHeightRatio).isActive = true
        
    }
    

    func addButtons() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let item = UINavigationItem()
        cameraButton.tintColor = .white
        profileButton.tintColor = .white
        item.leftBarButtonItem = cameraButton
        item.rightBarButtonItem = profileButton
        item.title = "Main Menu"
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Economica" , size: 45), NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.items = [item]
        view.addSubview(navigationBar)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
    }
    
    func addSubviews() {
        addButtons()
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
