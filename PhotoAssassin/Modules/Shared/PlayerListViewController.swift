//
//  PlayerListViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class PlayerListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var gradient: SubsectionGradient?
    private var players: [Player]
    private let cornerRadius: CGFloat = 15.0
    private let onPlayerSelected: ((Player, Int) -> Void)?

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        return view
    }()

    func getReuseIdentifier() -> String {
        return "playerListReuseIdentifier"
    }

    func update(newPlayers: [Player]) {
        self.players = newPlayers
        self.tableView.reloadData()
    }

    // MARK: - Table view data source/delegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PlayerListCell {
        let maybeCell = tableView.dequeueReusableCell(withIdentifier: getReuseIdentifier())
        var cell: PlayerListCell
        cell = maybeCell as? PlayerListCell ?? PlayerListCell()
        cell.textLabel?.text = players[indexPath.row].username
        cell.accessoryView = ChangeFriendStatusAccessory(player: players[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayerListCell = self.tableView(tableView, cellForRowAt: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PlayerListCell.getHeight()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onPlayerSelected?(players[indexPath.row], indexPath.row)
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        if let gradient = gradient {
            gradient.addToView(view)
        } else {
            view.backgroundColor = Colors.subsectionBackground
            view.layer.cornerRadius = cornerRadius
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient?.layoutInView(view)
    }

    override func loadView() {
        view = tableView
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        self.players = []
        self.onPlayerSelected = nil
        super.init(coder: aDecoder)
    }
    init(players list: [Player],
         hasGradientBackground: Bool,
         onPlayerSelected: ((Player, Int) -> Void)? = nil
    ) {
        self.players = list
        self.onPlayerSelected = onPlayerSelected
        if hasGradientBackground {
            self.gradient = SubsectionGradient()
        }
        super.init(nibName: nil, bundle: nil)
    }
}
