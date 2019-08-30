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
    private let bgGradient = BackgroundGradient()

    func push(navigationScreen: MenuNavigationController.Screen) {
        if let navController = navigationController as? MenuNavigationController {
            navController.push(navigationScreen)
        } else {
            print("WARNING: Using push(navigationScreen:) from outside a MenuNavigationController")
        }
    }
    func pop() {
        if let navController = navigationController as? MenuNavigationController {
            navController.pop()
        }
    }
    func routeTo(screen: RootRouter.Screen, animatedWithOptions options: UIView.AnimationOptions? = nil) {
        if let navController = navigationController as? MenuNavigationController {
            navController.routeTo(screen: screen, animatedWithOptions: options)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = MenuNavigationTitle(title ?? "")
        backButton.tintColor = .white
        navigationItem.backBarButtonItem = backButton
        bgGradient.addToView(view)
    }
    override func viewWillLayoutSubviews() {
        bgGradient.layoutInView(view)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
}
