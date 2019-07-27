//
//  PlayerProfileButton.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 7/27/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class PlayerProfileButton: UIButton {
    let player: Player?
    let viewController: NavigatingViewController?

    @objc
    func buttonTapped() {
        if let thePlayer = player {
            viewController?.push(navigationScreen: .profile(thePlayer))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        self.player = nil
        self.viewController = nil
        super.init(coder: aDecoder)
    }
    init(player: Player, parentVC: NavigatingViewController) {
        self.player = player
        self.viewController = parentVC
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}
