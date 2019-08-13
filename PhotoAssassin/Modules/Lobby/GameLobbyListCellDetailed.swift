//
//  GameLobbyListCellDetailed.swift
//  PhotoAssassin
//
//  Created by Edward Huang on 13/8/2019.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit
import FirebaseAuth

class GameLobbyListCellDetailed: UITableViewCell {
    static let horizontalMargin: CGFloat = 15.0
    static let textSize: CGFloat = 36.0
    static let smallTextSize: CGFloat = 20.0
    let edgeCurve: CGFloat = 12.0
    let textSpacing: CGFloat = 15.0
    let sideSpacing: CGFloat = 10.0
    
    let faceButton = UIButton(frame: .zero)
    let lobbyName = UITextView()
    let playerCountLabel = UILabel(frame: .zero)
    let targetLabel = UILabel(frame: .zero)
    let check = UIImageView(frame: .zero)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(lobby: GameLobby) {
        super.init(style: .default, reuseIdentifier: GameLobbyListCell.cellReuseIdentifer)
        faceButton.setTitle("hello", for: .normal)
        lobbyName.text = lobby.title
        lobbyName.font = R.font.economicaBold(size: GameLobbyListCellDetailed.textSize)
        lobbyName.textColor = Colors.text
        lobbyName.isEditable = false
        lobbyName.isSelectable = false
        faceButton.addSubview(lobbyName)
        
        playerCountLabel.text = "Players remaining: \(lobby.numberInLobby)"
        playerCountLabel.textColor = Colors.text
        playerCountLabel.font = R.font.economicaBold(size: GameLobbyListCellDetailed.smallTextSize)
        faceButton.addSubview(playerCountLabel)
        
        targetLabel.text = "Target: Jason"
        targetLabel.textColor = Colors.text
        targetLabel.font = R.font.economicaBold(size: GameLobbyListCellDetailed.smallTextSize)
        faceButton.addSubview(targetLabel)
        
        check.image = R.image.addFriend()
        faceButton.addSubview(check)
        addButtonConstraints()
        addSubview(faceButton)
        backgroundView = nil
        backgroundColor = Colors.subsectionBackground
        selectionStyle = .none
        layer.cornerRadius = edgeCurve
        addConstraints()
    }
    func addButtonConstraints() {
        lobbyName.topAnchor.constraint(equalTo: faceButton.topAnchor, constant: 20).isActive = true
        lobbyName.centerXAnchor.constraint(equalTo: faceButton.centerXAnchor).isActive = true
        playerCountLabel.topAnchor.constraint(equalTo: faceButton.topAnchor, constant: textSpacing).isActive = true
        playerCountLabel.leftAnchor.constraint(equalTo: faceButton.leftAnchor, constant: sideSpacing).isActive = true
        targetLabel.topAnchor.constraint(equalTo: playerCountLabel.bottomAnchor, constant: textSpacing).isActive = true
        targetLabel.leftAnchor.constraint(equalTo: faceButton.leftAnchor, constant: sideSpacing).isActive = true
        targetLabel.bottomAnchor.constraint(equalTo: faceButton.bottomAnchor, constant: -sideSpacing).isActive = true
        check.rightAnchor.constraint(equalTo: faceButton.rightAnchor, constant: -sideSpacing).isActive = true
        check.centerYAnchor.constraint(equalTo: faceButton.centerYAnchor).isActive = true
    }
    func addConstraints() {
        faceButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        faceButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        faceButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        faceButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        faceButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        faceButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        faceButton.translatesAutoresizingMaskIntoConstraints = false
    }
    static func getHeight() -> CGFloat {
        return textSize * 5
    }
}
