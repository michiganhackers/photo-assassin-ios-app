//
//  NotifSwitch.swift
//  PhotoAssassin
//
//  Created by Alex Wang on 10/17/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class NotifSwitch: UISwitch {
    let name: String
    
    
    required init?(coder: NSCoder) {
        self.name = ""
        super.init(coder: coder)
    }
    
    init(name: String) {
        self.name = name
        super.init(frame: .zero)
    }

}
