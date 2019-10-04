//
//  AttributionsViewController.swift
//  PhotoAssassin
//
//  Created by Tyler Brandt on 9/26/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit

class AttributionsViewController: NavigatingViewController {
    // MARK: - Class constants
    static let labelTextSize: CGFloat = 36.0
    static let fieldSpacing: CGFloat = 30.0
    static let largeTextSize: CGFloat = 30.0
    let verticalSpacing: CGFloat = 10.0
    let sameASpacing: CGFloat = 0.0
    // MARK: - Attributions list
    let listBreak = TranslucentLabel(text: "", size: fieldSpacing)
    let attribution1 = TranslucentLabel(text: "Icons made by Icons8", size: largeTextSize)
    let a1c = TranslucentLabel(text: "from www.flaticon.com", size: largeTextSize)
    let attribution2 = TranslucentLabel(text: "Icons made by Freepik", size: largeTextSize)
    let a2c = TranslucentLabel(text: "from www.flaticon.com", size: largeTextSize)
    let attribution3 = TranslucentLabel(text: "Icons made by Chanut", size: largeTextSize)
    let a3c = TranslucentLabel(text: "from www.flaticon.com", size: largeTextSize)
    // MARK: - Custom functions
    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        listBreak.topAnchor.constraint(equalTo: margins.topAnchor,
                                       constant: verticalSpacing).isActive = true
        listBreak.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        attribution1.topAnchor.constraint(equalTo: listBreak.bottomAnchor,
                                          constant: verticalSpacing).isActive = true
        attribution1.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        a1c.topAnchor.constraint(equalTo: attribution1.bottomAnchor,
                                          constant: sameASpacing).isActive = true
        a1c.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        attribution2.topAnchor.constraint(equalTo: a1c.bottomAnchor,
                                          constant: verticalSpacing).isActive = true
        attribution2.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        a2c.topAnchor.constraint(equalTo: attribution2.bottomAnchor,
                                          constant: sameASpacing).isActive = true
        a2c.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        attribution3.topAnchor.constraint(equalTo: a2c.bottomAnchor,
                                          constant: verticalSpacing).isActive = true
        attribution3.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        a3c.topAnchor.constraint(equalTo: attribution3.bottomAnchor,
                                 constant: sameASpacing).isActive = true
        a3c.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
    }
    func addSubviews() {
        view.addSubview(listBreak)
        view.addSubview(attribution1)
        view.addSubview(a1c)
        view.addSubview(attribution2)
        view.addSubview(a2c)
        view.addSubview(attribution3)
        view.addSubview(a3c)
    }
    // MARK: - Overrides
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(title: "Attributions")
    }
}
