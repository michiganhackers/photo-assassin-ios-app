//
//  RootRouter.swift
//  Photo Assassin
//
//  Copyright © Michigan Hackers. All rights reserved.
//

import UIKit

class RootRouter {
    // MARK: - Stored View Controllers
    private lazy var registerVC: UIViewController = {
        let controller = RegisterViewController()
        controller.router = self
        return controller
    }()
    private lazy var loginVC: UIViewController = {
        let controller = LoginViewController()
        controller.router = self
        return controller
    }()

    // MARK: - Nested Types
    enum Screen {
        case login
        case register
    }

    // MARK: - Public Functions
    func transitionTo(screen: Screen, animatedWithOptions: UIView.AnimationOptions?) {
        var controller: UIViewController
        switch screen {
        case .login:
            controller = loginVC
        case .register:
            controller = registerVC
        }
        setRootViewController(controller: controller,
                              animatedWithOptions: animatedWithOptions)
    }

    /** Replaces root view controller. You can specify the replacment animation type.
     If no animation type is specified, there is no animation */
    func setRootViewController(controller: UIViewController, animatedWithOptions: UIView.AnimationOptions?) {
        guard let window = UIApplication.shared.keyWindow else {
            fatalError("No window in app")
        }
        if let animationOptions = animatedWithOptions, window.rootViewController != nil {
            window.rootViewController = controller
            UIView.transition(with: window, duration: 0.33, options: animationOptions, animations: {
            }, completion: nil)
        } else {
            window.rootViewController = controller
        }
    }

    func loadMainAppStructure() {
        // TODO: Implement logins
        let isLoggedIn = false
        var controller: UIViewController

        if isLoggedIn {
            controller = UIViewController()//MainScreenViewController()
        } else {
            controller = registerVC
        }
        // controller.view.backgroundColor = UIColor.red
        setRootViewController(controller: controller, animatedWithOptions: nil)
    }
}
