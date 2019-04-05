//
//  MenuNavigationController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/4/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class MenuNavigationController: RoutedNavigationController {
    let backgroundGradient = BackgroundGradient()

    let activeGamesVC = ActiveGamesViewController()
    let menuVC = MenuViewController()
    let newGameVC = NewGameViewController()

    enum Screen {
        case activeGames
        case menu
        case newGame
    }

    func push(_ screen: Screen) {
        var viewControllerToPush: NavigatingViewController
        switch screen {
        case .activeGames:
            viewControllerToPush = activeGamesVC
        case .menu:
            viewControllerToPush = menuVC
        case .newGame:
            viewControllerToPush = newGameVC
        }
        pushViewController(viewControllerToPush, animated: true)
    }

    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(navigationBarClass: MenuNavigationBar.self, toolbarClass: nil)
        pushViewController(menuVC, animated: false)
    }

    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundGradient.layoutInView(view)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundGradient.addToView(view)
    }
}
