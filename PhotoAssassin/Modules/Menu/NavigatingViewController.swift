//
//  NavigatingViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/5/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//
//  This class should be used for all view controllers that will be created
//  within a MenuNavigationController. A NavigatingViewController just needs its
//  title to be initialized.

import UIKit

class NavigatingViewController: UIViewController {
    private let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    func push(navigationScreen: MenuNavigationController.Screen) {
        if let navController = navigationController as? MenuNavigationController {
            navController.push(navigationScreen)
        }
    }
    func pop() {
        if let navController = navigationController as? MenuNavigationController {
            navController.pop()
        }
    }
    func routeTo(screen: RootRouter.Screen) {
        if let navController = navigationController as? MenuNavigationController {
            navController.routeTo(screen: screen)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = MenuNavigationTitle(title ?? "")
        backButton.tintColor = .white
        navigationItem.backBarButtonItem = backButton
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
}
