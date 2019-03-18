//
//  BackgroundGradient.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 3/18/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//
//  This class represents the red background gradient used on most screens of
//  the app. Once a BackgroundGradient is created, its addToView(_:UIView)
//  function should be called in a UIViewController's viewDidLoad() function and
//  its layoutInView(_:UIView) function should be called in UIViewController's
//  viewWillLayoutSubviews() function.

import UIKit

class BackgroundGradient: CAGradientLayer {
    // MARK: - Private Functions
    private func addColors() {
        colors = [
            Colors.startBackgroundGradient.cgColor,
            Colors.endBackgroundGradient.cgColor
        ]
    }

    // MARK: - Public Functions
    func addToView(_ view: UIView) {
        view.layer.insertSublayer(self, at: 0)
        view.backgroundColor = Colors.behindGradient
    }

    func layoutInView(_ view: UIView) {
        self.frame = view.bounds
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addColors()
    }

    override init() {
        super.init()
        addColors()
    }
}
