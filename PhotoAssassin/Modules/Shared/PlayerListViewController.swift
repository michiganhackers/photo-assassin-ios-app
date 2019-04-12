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
    private let players: [Player]

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

    // MARK: - Table view data source/delegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PlayerListCell {
        let maybeCell = tableView.dequeueReusableCell(withIdentifier: getReuseIdentifier())
        if let cell = maybeCell as? PlayerListCell {
            cell.textLabel?.text = players[indexPath.row].name
            return cell
        }
        let cell = PlayerListCell()
        cell.textLabel?.text = players[indexPath.row].name
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

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient?.addToView(view)
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
        super.init(coder: aDecoder)
    }
    init(players list: [Player], hasGradientBackground: Bool) {
        self.players = list
        if hasGradientBackground {
            self.gradient = SubsectionGradient()
        }
        super.init(nibName: nil, bundle: nil)
    }
}
