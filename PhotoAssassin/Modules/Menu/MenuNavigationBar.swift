//
//  MenuNavigationBar.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/4/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class MenuNavigationBar: UINavigationBar {
    let titleFontSize: CGFloat = 25.0
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleTextAttributes = [
            .font: R.font.economicaBold(size: titleFontSize) ??
                UIFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: UIColor.white
        ]
        //  navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }

}
