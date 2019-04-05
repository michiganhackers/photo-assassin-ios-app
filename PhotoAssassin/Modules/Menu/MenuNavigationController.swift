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
    let menuVC = MenuViewController()

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
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundGradient.layoutInView(view)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundGradient.addToView(view)
    }
}
