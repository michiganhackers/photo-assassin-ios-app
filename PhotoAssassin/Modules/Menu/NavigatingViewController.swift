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

class NavigatingViewController: RoutedViewController {
    func push(navigationScreen: MenuNavigationController.Screen) {
        if let navController = navigationController as? MenuNavigationController {
            navController.push(navigationScreen)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = MenuNavigationTitle(title ?? "")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
}
