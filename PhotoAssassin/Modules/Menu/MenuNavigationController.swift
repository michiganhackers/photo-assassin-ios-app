//
//  MenuNavigationController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/4/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class MenuNavigationController: RoutedNavigationController {
    let changeEmailVC = ChangeEmailViewController()
    let changePasswordVC = ChangePasswordViewController()
    let menuVC = MenuViewController()
    let newGameVC = NewGameViewController()
    let notificationsSettingsVC = NotificationsSettingsViewController()
    let settingsVC = SettingsViewController()
    let attributionsVC = AttributionsViewController()

    enum Screen {
        case changeEmail
        case changePassword
        case gameHistory(Player)
        case lobbyInfo(LobbyInfo)
        case menu
        case newGame
        case notificationsSettings
        case profile(Player)
        case settings
        case viewAttributions
    }

    func push(_ screen: Screen) {
        var viewControllerToPush: NavigatingViewController
        switch screen {
        case .changeEmail:
            viewControllerToPush = changeEmailVC
        case .changePassword:
            viewControllerToPush = changePasswordVC
        case let .gameHistory(player):
            viewControllerToPush = GameHistoryViewController(player: player)
        case let .lobbyInfo(info):
            viewControllerToPush = LobbyViewController(info: info)
        case .menu:
            viewControllerToPush = menuVC
        case .newGame:
            viewControllerToPush = newGameVC
        case .notificationsSettings:
            viewControllerToPush = notificationsSettingsVC
        case let .profile(player):
            viewControllerToPush = ProfileViewController(player: player)
        case .settings:
            viewControllerToPush = settingsVC
        case .viewAttributions:
            viewControllerToPush = attributionsVC
        }
        pushViewController(viewControllerToPush, animated: true)
    }
    func pop() {
        popViewController(animated: true)
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
