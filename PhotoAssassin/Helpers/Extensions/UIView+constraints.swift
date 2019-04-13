//
//  UIView+constraints.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/13/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

extension UIView {
    // Creates constraints for views descending from this view downward
    func stackViewsDown(
        views: [(UIView, CGFloat)],
        left: NSLayoutXAxisAnchor,
        right: NSLayoutXAxisAnchor,
        marginLeft: CGFloat = 0.0,
        marginRight: CGFloat = 0.0
    ) {
        var lastTop = self.bottomAnchor
        for (view, marginTop) in views {
            view.topAnchor.constraint(equalTo: lastTop,
                                      constant: marginTop).isActive = true
            view.leftAnchor.constraint(equalTo: left,
                                       constant: marginLeft).isActive = true
            view.rightAnchor.constraint(equalTo: right,
                                        constant: -marginRight).isActive = true
            lastTop = view.bottomAnchor
        }
    }

    // Creates constraints on the left, right, top, and bottom of a this view
    func anchor(
        left: NSLayoutXAxisAnchor?,
        right: NSLayoutXAxisAnchor?,
        top: NSLayoutYAxisAnchor?,
        bottom: NSLayoutYAxisAnchor?,
        marginLeft: CGFloat = 0.0,
        marginRight: CGFloat = 0.0,
        marginTop: CGFloat = 0.0,
        marginBottom: CGFloat = 0.0
    ) {
        if let left = left {
            leftAnchor.constraint(
                equalTo: left, constant: marginLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(
                equalTo: right, constant: -marginRight).isActive = true
        }
        if let top = top {
            topAnchor.constraint(
                equalTo: top, constant: marginTop).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(
                equalTo: bottom, constant: -marginBottom).isActive = true
        }
    }
}
