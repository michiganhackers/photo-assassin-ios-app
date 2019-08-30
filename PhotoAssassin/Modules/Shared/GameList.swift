//
//  GameList.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 8/3/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class GameList<CellType: GameDataCell>: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let borderWidth: CGFloat = 2.0
    let separatorMargin: CGFloat = 5.0
    let footerHeight: CGFloat = 8.0

    let onSelect: ((CellType.GameDataType, Int) -> Void)?

    var games: [CellType.GameDataType] = []

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
        return CellType(gameData: games[indexPath.section]).cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(games[indexPath.section], indexPath.section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellType.getHeight()
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

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        self.onSelect = nil
        super.init(coder: aDecoder)
    }
    init(onSelect: @escaping (CellType.GameDataType, Int) -> Void) {
        self.onSelect = onSelect
        super.init(nibName: nil, bundle: nil)
    }
}
