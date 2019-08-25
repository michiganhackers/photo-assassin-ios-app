//
//  PlayerListCell.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 8/10/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class LobbyPlayerListCell: UITableViewCell, GameDataCell {
    typealias GameDataType = LobbyInfo.PlayerWithStatus

    static let horizontalMargin: CGFloat = 15.0
    static let placeTextSize: CGFloat = 30.0
    static let textSize: CGFloat = 36.0
    static let cellReuseIdentifer = "lobbyPlayerCell"
    let edgeCurve: CGFloat = 12.0

    let killsLabel = UILabel(frame: .zero)
    let placeLabel = UILabel(frame: .zero)
    let relationshipImage = UIImageView(frame: .zero)
    let gameData: LobbyInfo.PlayerWithStatus?

    var cell: UITableViewCell {
        return self
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let place = gameData?.stats.place, let ctxt = UIGraphicsGetCurrentContext() {
            if place <= 3 {
                var color = Colors.black
                switch place {
                case 1:
                    color = Colors.gold
                case 2:
                    color = Colors.silver
                default:
                    color = Colors.bronze
                }
                let circleRect = CGRect(
                    x: rect.minX + type(of: self).horizontalMargin,
                    y: (rect.height - type(of: self).getIconHeight()) / 2.0,
                    width: type(of: self).getIconHeight(),
                    height: type(of: self).getIconHeight()
                )
                ctxt.addEllipse(in: circleRect)
                ctxt.setFillColor(color.cgColor)
                ctxt.fillPath()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        self.gameData = nil
        super.init(coder: aDecoder)
    }
    required init(gameData: LobbyInfo.PlayerWithStatus) {
        self.gameData = gameData
        super.init(style: .default, reuseIdentifier: type(of: self).cellReuseIdentifer)
        textLabel?.text = gameData.player.username
        textLabel?.textColor = Colors.text
        textLabel?.textAlignment = .left
        textLabel?.font = R.font.economicaBold(size: type(of: self).textSize)

        if gameData.stats.didStartGame {
            contentView.addSubview(killsLabel)
            killsLabel.textAlignment = .right
            killsLabel.text = "\(gameData.stats.kills ?? 0)"
            killsLabel.textColor = Colors.text
            killsLabel.font = R.font.economicaBold(size: type(of: self).textSize)
        }
        if let place = gameData.stats.place {
            contentView.addSubview(placeLabel)
            placeLabel.textAlignment = .center
            placeLabel.textColor = Colors.black
            placeLabel.font = R.font.economicaBold(size: type(of: self).placeTextSize)
            if place == 1 {
                placeLabel.text = "1st"
            } else if place == 2 {
                placeLabel.text = "2nd"
            } else if place == 3 {
                placeLabel.text = "3rd"
            }
        }
        if gameData.stats.didStartGame && !gameData.stats.didGameEnd {
            contentView.addSubview(relationshipImage)
            if gameData.player.relationship != .myself {
                switch gameData.relationship {
                case .dead:
                    relationshipImage.image = R.image.skull()
                case .neutral:
                    relationshipImage.image = R.image.satisfied()?.withRenderingMode(.alwaysTemplate)
                    relationshipImage.tintColor = Colors.success
                case .target:
                    relationshipImage.image = R.image.target()
                }
            }
        }

        backgroundView = nil
        backgroundColor = Colors.subsectionBackground
        selectionStyle = .none
        layer.cornerRadius = edgeCurve
        layer.masksToBounds = true
        addConstraints()
    }

    func addConstraints() {
        if let gameData = self.gameData, let titleLabel = textLabel {
            var left = self.leftAnchor
            if gameData.stats.didStartGame && !gameData.stats.didGameEnd {
                relationshipImage.leftAnchor.constraint(
                    equalTo: left,
                    constant: type(of: self).horizontalMargin
                ).isActive = true
                relationshipImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                relationshipImage.widthAnchor.constraint(
                    equalToConstant: type(of: self).getIconHeight()).isActive = true
                relationshipImage.heightAnchor.constraint(equalTo: relationshipImage.widthAnchor).isActive = true
                relationshipImage.translatesAutoresizingMaskIntoConstraints = false
                left = relationshipImage.rightAnchor
            }
            if gameData.stats.place != nil {
                placeLabel.leftAnchor.constraint(equalTo: left,
                                                 constant: type(of: self).horizontalMargin).isActive = true
                placeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                placeLabel.widthAnchor.constraint(
                    equalToConstant: type(of: self).getIconHeight()).isActive = true
                placeLabel.heightAnchor.constraint(equalTo: placeLabel.widthAnchor).isActive = true
                placeLabel.translatesAutoresizingMaskIntoConstraints = false
                left = placeLabel.rightAnchor
            }
            titleLabel.leftAnchor.constraint(equalTo: left,
                                             constant: type(of: self).horizontalMargin).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            if gameData.stats.didStartGame {
                killsLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                  constant: -type(of: self).horizontalMargin).isActive = true
                killsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                killsLabel.translatesAutoresizingMaskIntoConstraints = false
            }
        }
    }
    static func getHeight() -> CGFloat {
        return 90.0
    }
    static func getImageHeight() -> CGFloat {
        return getHeight() * 0.8
    }
    static func getIconHeight() -> CGFloat {
        return getHeight() * 0.6
    }
}
