//
//  AddPlayerViewController.swift
//  PhotoAssassin
//
//  Created by Jason Siegelin on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class AddPlayerViewController: NavigatingViewController {

    let spaceTitleAndInviteField: CGFloat = 4.0
    let horizontalFieldSpacing: CGFloat = 12.0
    let mainTextSize: CGFloat = 24.0
    let separatorHeight: CGFloat = 4.0
    let barConstant: CGFloat = 7.0
    let inviteTitleSpacing: CGFloat = 10.0
    let inviteTitleAndFieldSpace: CGFloat = 1.0
    let cancelButtonItem = UIBarButtonItem(title: "X", style: .plain, target: nil, action: nil)
    
    lazy var inviteLinkField: UITextField = {
        let inviteField = UserEnterTextField("")
        return inviteField
    }()
    lazy var inviteFieldTitle: UILabel = {
        let inviteTitle = UILabel()
        inviteTitle.attributedText = NSAttributedString(
            string: "Invite Link",
            attributes: [
                .foregroundColor: Colors.seeThroughText,
                .font: R.font.economicaBold.orDefault(size: mainTextSize)
            ]
        )
        return inviteTitle
    }()
    lazy var separatingBar: UIView = {
        let separateBar = UIView()
        separateBar.backgroundColor = Colors.seeThroughText
        separateBar.heightAnchor.constraint(equalToConstant: separatorHeight).isActive = true
        separateBar.translatesAutoresizingMaskIntoConstraints = false
        return separateBar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    func addSubviews() {
        addNavButtons()
        view.addSubview(inviteLinkField)
        view.addSubview(inviteFieldTitle)
        view.addSubview(separatingBar)
    }
    func addNavButtons() {
        cancelButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = cancelButtonItem
    }
    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        // inviteFieldTitle
        inviteFieldTitle.topAnchor.constraint(equalTo: margins.topAnchor,
                                              constant: spaceTitleAndInviteField).isActive = true
        inviteFieldTitle.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                              constant: inviteTitleSpacing).isActive = true
        // inviteLinkField
        inviteLinkField.topAnchor.constraint(equalTo: inviteFieldTitle.bottomAnchor,
                                          constant: inviteTitleAndFieldSpace).isActive = true
        inviteLinkField.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                          constant: horizontalFieldSpacing).isActive = true
        inviteLinkField.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                          constant: horizontalFieldSpacing).isActive = true
        // separatingBar
        separatingBar.topAnchor.constraint(equalTo: inviteLinkField.bottomAnchor,
                                           constant: barConstant).isActive = true
        separatingBar.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                           constant: horizontalFieldSpacing).isActive = true
        separatingBar.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                            constant: horizontalFieldSpacing).isActive = true
        
    }
    init() {
        super.init(title: "Add Player to Game")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
