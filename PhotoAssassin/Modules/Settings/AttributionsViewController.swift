//
//  ChangeEmailViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 6/26/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit

class AttributionsViewController: NavigatingViewController {
    // MARK: - Class constants
    static let labelTextSize: CGFloat = 36.0
    static let fieldSpacing: CGFloat = 30.0
    // MARK: - Custom functions
    func setUpConstraints() {
    }
    func addSubviews() {
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
