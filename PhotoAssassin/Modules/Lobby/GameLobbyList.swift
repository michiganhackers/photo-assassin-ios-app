//
//  GameLobbyList.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 3/21/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class GameLobbyList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let borderWidth: CGFloat = 2.0
    let separatorMargin: CGFloat = 5.0
    let footerHeight: CGFloat = 8.0

    let gameLobbies = [
        GameLobby(title: "Game 1", description: "This is a game",
                  numberInLobby: 3, capacity: 5),
        GameLobby(title: "Another Game", description: "This is some other game",
                  numberInLobby: 8, capacity: 20),
        GameLobby(title: "Game 3", description: "Yo this is Game 3, B",
                  numberInLobby: 4, capacity: 6),
        GameLobby(title: "Jason's Game", description: "Jason Siegelin is cool",
                  numberInLobby: 6, capacity: 100)
    ]

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return GameLobbyListCell(lobby: gameLobbies[indexPath.section])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("This is working")
        print(indexPath.section)
        if let cell = tableView.cellForRow(at: indexPath) as? GameLobbyListCell {
            cell.addConstraints()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return gameLobbies.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GameLobbyListCell.getHeight()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Returning an empty footer prevents the UITableView from drawing unnecessary
        //  separators where there aren't cells.
        return UIView()
    }

    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = nil
        tableView.backgroundColor = nil
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Colors.text
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: separatorMargin,
                                      bottom: 0.0, right: separatorMargin)
    }
}
