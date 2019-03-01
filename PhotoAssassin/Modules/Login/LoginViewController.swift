//
//  LoginViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 2/28/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class LoginViewController: LoginRegisterViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(buttonText: "log in") { (_ email: String, _ password: String) -> Void in
            print("Attempted log in with email \(email) and password \(password)")
        }
    }
}
