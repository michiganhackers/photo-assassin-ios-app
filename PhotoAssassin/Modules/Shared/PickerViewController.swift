//
//  PickerViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/5/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

protocol PickerViewControllerDelegate: AnyObject {
    func optionWasSelected(option index: Int)
}

class PickerViewController<T>:
UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Class members
    private var isFirstLoad = true
    let options: [(String, T)]
    let defaultRow: Int
    let borderWidth: CGFloat = 1.0
    let reuseID = "PickerViewCell"
    weak var delegate: PickerViewControllerDelegate?

    // MARK: - UI elements
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.dataSource = self
        view.delegate = self
        view.allowsMultipleSelection = false
        return view
    }()

    // MARK: - UITableViewDelegate / UITableViewDataSource methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let maybeCell = tableView.dequeueReusableCell(withIdentifier: reuseID)
        if let cell = maybeCell as? PickerViewCell {
            cell.textLabel?.text = options[indexPath.row].0
            return cell
        }
        let cell = PickerViewCell(style: .default, reuseIdentifier: reuseID)
        cell.textLabel?.text = options[indexPath.row].0
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PickerViewCell.getHeight()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        delegate?.optionWasSelected(option: indexPath.row)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }

    // MARK: - Overrides
    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = nil
        tableView.backgroundColor = nil
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Colors.text
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstLoad {
            let path = IndexPath(row: defaultRow, section: 0)
            tableView.selectRow(at: path, animated: animated, scrollPosition: .none)
            tableView(tableView, didSelectRowAt: path)
            isFirstLoad = false
        }
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        self.options = []
        self.defaultRow = 0
        super.init(coder: aDecoder)
    }
    init(options: [(String, T)], defaultRow: Int = 0) {
        self.options = options
        self.defaultRow = defaultRow
        super.init(nibName: nil, bundle: nil)
    }
}
