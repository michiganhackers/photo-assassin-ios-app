//
//  GameLobbyListCellDetailed.swift
//  PhotoAssassin
//
//  Created by Edward Huang on 13/8/2019.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import FirebaseAuth
import UIKit

class GameLobbyListCellDetailed: UITableViewCell, GameDataCell {
    typealias GameDataType = GameLobby

    static let horizontalMargin: CGFloat = 15.0
    static let textSize: CGFloat = 36.0
    static let smallTextSize: CGFloat = 20.0
    static let cellHeight: CGFloat = 140
    static let cellReuseIdentifer = "gameLobbyCellDetailed"
    let edgeCurve: CGFloat = 12.0
    let textSpacing: CGFloat = 5.0
    let sideSpacing: CGFloat = 10.0

    let faceButton = UIButton(frame: .zero)
    let lobbyName = UITextView(frame: .zero)
    let playerCountLabel = UILabel(frame: .zero)
    let targetLabel = UILabel(frame: .zero)
    let check = UIImageView(frame: .zero)

    var cell: UITableViewCell {
        return self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    required init(gameData: GameLobby) {
        super.init(style: .default, reuseIdentifier: GameLobbyListCellDetailed.cellReuseIdentifer)
        faceButton.setTitle(gameData.title, for: .normal)
        faceButton.setTitleColor(Colors.text, for: .normal)
        faceButton.titleLabel?.font = R.font.economicaBold(size: GameLobbyListCellDetailed.textSize)
        faceButton.backgroundColor = .clear
        faceButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        faceButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top

        playerCountLabel.text = "Players remaining: \(gameData.numberInLobby)"
        playerCountLabel.textColor = Colors.text
        playerCountLabel.font = R.font.economicaBold(size: GameLobbyListCellDetailed.smallTextSize)
        playerCountLabel.translatesAutoresizingMaskIntoConstraints = false
        faceButton.addSubview(playerCountLabel)
        
        targetLabel.text = "Target: Jason"
        targetLabel.textColor = Colors.text
        targetLabel.font = R.font.economicaBold(size: GameLobbyListCellDetailed.smallTextSize)
        targetLabel.translatesAutoresizingMaskIntoConstraints = false
        faceButton.addSubview(targetLabel)

        check.image = R.image.checkmark()?.withRenderingMode(.alwaysTemplate)
        check.tintColor = .white
        check.layer.opacity = 0.0
        check.translatesAutoresizingMaskIntoConstraints = false
        faceButton.addSubview(check)
        addButtonConstraints()
        faceButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        addSubview(faceButton)
        backgroundView = nil
        backgroundColor = Colors.subsectionBackground
        selectionStyle = .none
        layer.cornerRadius = edgeCurve
        addConstraints()
    }
    func addButtonConstraints() {
        playerCountLabel.topAnchor.constraint(equalTo: faceButton.topAnchor, constant: 70).isActive = true
        playerCountLabel.leftAnchor.constraint(equalTo: faceButton.leftAnchor, constant: sideSpacing).isActive = true
        targetLabel.topAnchor.constraint(equalTo: playerCountLabel.bottomAnchor, constant: textSpacing).isActive = true
        targetLabel.leftAnchor.constraint(equalTo: faceButton.leftAnchor, constant: sideSpacing).isActive = true
        check.rightAnchor.constraint(equalTo: faceButton.rightAnchor, constant: -sideSpacing).isActive = true
        check.centerYAnchor.constraint(equalTo: faceButton.centerYAnchor).isActive = true
    }
    func addConstraints() {
        faceButton.translatesAutoresizingMaskIntoConstraints = false
        faceButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        faceButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        faceButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        faceButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        faceButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        faceButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    static func getHeight() -> CGFloat {
        return cellHeight
    }
    func isSelected() -> Bool {
        return check.layer.opacity == 1.0
    }
    @objc
    func selected() {
        check.layer.opacity = check.layer.opacity == 0.0 ? 1.0 : 0.0
    }
}
