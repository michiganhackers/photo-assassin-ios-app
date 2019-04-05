//
//  NewGameViewController.swift
//  PhotoAssassin
//
//  Created by Anna on 2019/4/4.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class NewGameViewController: RoutedViewController {
    
    lazy var createButton: UIButton = {
        let gameButton = TranslucentButton("Create")
        gameButton.addTarget(self, action: #selector(bringToCreate), for: .touchUpInside)
        return gameButton
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.attributedText = NSAttributedString(string: "Title",
        attributes: [NSAttributedString.Key.foregroundColor:UIColor.white,
                     NSAttributedString.Key.font: UIFont(name: "Economica",
                                                         size: 25.0)!])
        return titleLabel
    }()
    
    lazy var addPlayerLabel: UILabel = {
        let addPlayerLabel = UILabel()
        addPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
        addPlayerLabel.attributedText = NSAttributedString(string: "Added Players",
        attributes: [NSAttributedString.Key.foregroundColor:UIColor.white,
                     NSAttributedString.Key.font: UIFont(name: "Economica",
                                                         size: 25.0)!])
        return addPlayerLabel
    }()
    
    lazy var titleTextField: UITextField = {
        let titleText = UserEnterTextField("")
        titleText.translatesAutoresizingMaskIntoConstraints = false
        return titleText
    }()
    
    @objc
    func bringToCreate() {
        print("create a new game")
        //navigationController?.pushViewController(NewGameViewController(), animated: true)
    }
    
    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        createButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        createButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(equalTo: margins.widthAnchor,
                                            multiplier: 1.0/3.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: margins.widthAnchor,
                                            multiplier: 1.0).isActive = true
        addPlayerLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor).isActive = true
        addPlayerLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
    }
    
    func addSubviews() {
        view.addSubview(createButton)
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(addPlayerLabel)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Game"
        addSubviews()
    }

}
