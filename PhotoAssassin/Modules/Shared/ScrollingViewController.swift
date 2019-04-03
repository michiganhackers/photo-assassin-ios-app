//
//  ScrollingViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/2/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//
//  This class provides an easy-to-use superclass for vertically scrollable
//  UIViewControllers. Subclasses should:
//    1) Use contentView instead of view for adding subviews, constraints, etc.
//    2) Override the getBottomSubview() method to return a view *iff the
//       subclass will not already be adding a constraint from its bottommost
//       element to contentView*

import UIKit

class ScrollingViewController: RoutedViewController {
    // MARK: - Private members
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    // MARK: - Public members
    // NOTE: You should use *contentView* instead of view in subclasses!!
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraints()
    }

    private func addConstraints() {
        let parentMargins = view.layoutMarginsGuide
        let margins = contentView.layoutMarginsGuide

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: parentMargins.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: parentMargins.widthAnchor).isActive = true

        if let bottomSubview = getBottomSubview() {
            bottomSubview.bottomAnchor.constraint(
                equalTo: margins.bottomAnchor
            ).isActive = true
        }
    }

    // MARK: - To be overriden by subclasses (unless you want to add your own
    //  constraints from contentView to the bottom subview)
    func getBottomSubview() -> UIView? {
        return nil
    }
}
