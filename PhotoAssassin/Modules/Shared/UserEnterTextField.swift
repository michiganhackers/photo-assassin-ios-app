//
//  UserEnterTextField.swift
//  PhotoAssassin
//
//  Created by Anna on 2019/4/4.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class UserEnterTextField: UITextField {

    let cornerRadius: CGFloat = 15.0
    let height: CGFloat = 67.0
    let textInsetX: CGFloat = 15.0
    let textSize: CGFloat = 36.0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textInsetX, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textInsetX, dy: 0)
    }
    
    convenience init(_ textContent: String) {
        self.init()
        layer.cornerRadius = cornerRadius
        backgroundColor = Colors.seeThroughContrast
        textColor = Colors.text
        
        let inputFont = R.font.economicaBold(size: textSize)
        font = inputFont
        
        if let font = inputFont {
            attributedPlaceholder = NSAttributedString(string: textContent,
                                                       attributes: [
                                                        .foregroundColor: Colors.seeThroughText,
                                                        .font: font
                ]
            )
        }
    }

}
