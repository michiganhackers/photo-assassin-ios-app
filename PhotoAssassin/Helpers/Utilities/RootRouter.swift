//
//  RootRouter.swift
//  Photo Assassin
//
//  Copyright © Michigan Hackers. All rights reserved.
//

import FirebaseAuth
import UIKit

class RootRouter {
    // MARK: - Stored View Controllers
    private lazy var menuNavVC: UINavigationController = {
        let controller = MenuNavigationController()
        controller.router = self
        return controller
    }()
    private lazy var cameraVC: UIViewController = {
        let controller = BaseCameraViewController()
        controller.router = self
        return controller
    }()
    private lazy var pictureChangeVC: UIViewController = {
        let controller = BaseCameraViewController()
        controller.router = self
        return controller
    }()
    private lazy var forgotPasswordVC: UIViewController = {
        let controller = ForgotPasswordViewController()
        controller.router = self
        return controller
    }()
    private lazy var loginVC: UIViewController = {
        let controller = LoginViewController()
        controller.router = self
        return controller
    }()
    private lazy var registerVC: UIViewController = {
        let controller = RegisterViewController()
        controller.router = self
        return controller
    }()
    private lazy var setUpProfileVC: UIViewController = {
        let controller = SetupProfileViewController()
        controller.router = self
        return controller
    }()

    // MARK: - Nested Types
    enum Screen {
        case camera
        case pictureChange
        case forgotPassword
        case login
        case register
        case menu
        case setupProfile
    }

    // MARK: - Public Functions
    func transitionTo(screen: Screen, animatedWithOptions: UIView.AnimationOptions?) {
        var controller: UIViewController
        switch screen {
        case .camera:
            controller = cameraVC
        case .pictureChange:
            controller = pictureChangeVC
        case .forgotPassword:
            controller = forgotPasswordVC
        case .login:
            controller = loginVC
        case .register:
            controller = registerVC
        case .setupProfile:
            controller = setUpProfileVC
        case .menu:
            controller = menuNavVC
            menuNavVC.popToRootViewController(animated: false)
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
        let isLoggedIn = Auth.auth().currentUser != nil
        var controller: UIViewController

        if isLoggedIn {
            controller = cameraVC
        } else {
            controller = loginVC
        }
        setRootViewController(controller: controller, animatedWithOptions: nil)
    }
}
