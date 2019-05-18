//
//  RootRouter.swift
//  Photo Assassin
//
//  Copyright © Michigan Hackers. All rights reserved.
//

import UIKit

class RootRouter {

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
            controller = ViewController()//MainScreenViewController()
        } else {
            controller = registerVC
        }
        controller = ViewController()
        // controller.view.backgroundColor = UIColor.red
        setRootViewController(controller: controller, animatedWithOptions: nil)
    }
}
