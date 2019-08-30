//
//  GameDataCell.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 8/3/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

protocol GameDataCell {
    associatedtype GameDataType
    static func getHeight() -> CGFloat

    var cell: UITableViewCell { get }
    init(gameData: GameDataType)
}
