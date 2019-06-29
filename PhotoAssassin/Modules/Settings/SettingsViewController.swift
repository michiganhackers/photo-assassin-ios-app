//
//  SettingsViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 6/22/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class SettingsViewController: NavigatingViewController,
                              UITableViewDelegate, UITableViewDataSource {
    // MARK: - Class constants
    let separatorMargin: CGFloat = 40.0
    let topMargin: CGFloat = 50.0
    let tableRows: [(String, UIImage?)] = [
        ("Change Email", R.image.email()),
        ("Change Password", R.image.lock()),
        ("Notifications", R.image.bell()),
        ("Logout", R.image.exit())
    ]
    lazy var tableActions: [() -> Void] = [
        changeEmail,
        changePassword,
        openNotifications,
        logout
    ]

    // MARK: - UITableView methods and members
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (label, image) = tableRows[indexPath.row]
        return SettingsCell(label: label, image: image)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = tableActions[indexPath.row]
        action()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingsCell.getHeight()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows.count
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Returning an empty footer prevents the UITableView from drawing unnecessary
        //  separators where there aren't cells.
        return UIView()
    }

    override func loadView() {
        view = tableView
    }

    // MARK: - Custom functions
    func changeEmail() {
        push(navigationScreen: .changeEmail)
    }

    func changePassword() {
        push(navigationScreen: .changePassword)
    }

    func openNotifications() {
        print("TODO: Open notifications")
    }

    func logout() {
        print("TODO: Logout")
        routeTo(screen: .login)
    }

    // MARK: - Overrides
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
        super.init(coder: aDecoder)
    }
    init() {
        super.init(title: "Settings")
    }
}
