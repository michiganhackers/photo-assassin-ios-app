//
//  FontResource+orDefault.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/4/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import Rswift
import UIKit

extension FontResource {
    func orDefault(size: CGFloat, style: UIFont.TextStyle = .body) -> UIFont {
        return UIFont(resource: self, size: size) ??
               UIFont.preferredFont(forTextStyle: style)
    }
}
