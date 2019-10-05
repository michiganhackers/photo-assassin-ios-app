//
//  SubsectionGradient.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/4/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class SubsectionGradient: CAGradientLayer {
    // MARK: - Private Functions
    private func addStyling() {
        colors = [
            Colors.subsectionBackground.cgColor,
            Colors.subsectionBackground.cgColor
        ]
        cornerRadius = 15.0
    }

    // MARK: - Public Functions
    func addToView(_ view: UIView) {
        view.layer.insertSublayer(self, at: 0)
        view.backgroundColor = .clear
    }

    func layoutInView(_ view: UIView) {
        self.frame = view.bounds
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addStyling()
    }

    override init(layer: Any) {
        super.init(layer: layer)
        addStyling()
    }

    override init() {
        super.init()
        addStyling()
    }
}
