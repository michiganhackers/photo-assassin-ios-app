//
//  RoutedViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 3/18/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//
//  This class can be used as a superclass for any UINavigationControllers. It
//  provides a router property that, when set to a RootRouter, allows the controller
//  to navigate to a different screen. If router is not set, routeTo does not
//  do anything.

import UIKit

class RoutedNavigationController: UINavigationController {
    var router: RootRouter?
    func routeTo(screen: RootRouter.Screen) {
        router?.transitionTo(screen: screen, animatedWithOptions: nil)
    }
}
