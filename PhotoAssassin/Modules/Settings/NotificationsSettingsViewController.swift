//
//  NotificationsSettingsViewController.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 7/13/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class NotificationsSettingsViewController: NavigatingViewController {
    // MARK: - Class constants
    static let largeTextSize: CGFloat = 30.0
    static let textSize: CGFloat = 24.0
    let leftOffset: CGFloat = 10.0
    let verticalSpacing: CGFloat = 10.0

    // MARK: - UI elements
    let voteNotifSwitch: UISwitch = {
        let theSwitch = UISwitch(frame: .zero)
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = true
        return theSwitch
    }()
    let eliminationNotifSwitch: UISwitch = {
        let theSwitch = UISwitch(frame: .zero)
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = true
        return theSwitch
    }()
    let overallLabel = TranslucentLabel(text: "Receive notifications when:", size: largeTextSize)
    let voteNotifLabel = TranslucentLabel(text: "You have a pending vote", size: textSize)
    let eliminationNotifLabel = TranslucentLabel(text: "Someone is eliminated", size: textSize)

    // MARK: - Custom methods
    func addSubviews() {
        view.addSubview(voteNotifSwitch)
        view.addSubview(eliminationNotifSwitch)
        view.addSubview(overallLabel)
        view.addSubview(voteNotifLabel)
        view.addSubview(eliminationNotifLabel)
    }
    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        overallLabel.topAnchor.constraint(equalTo: margins.topAnchor,
                                          constant: verticalSpacing).isActive = true
        overallLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        voteNotifLabel.topAnchor.constraint(equalTo: overallLabel.bottomAnchor,
                                            constant: verticalSpacing).isActive = true
        voteNotifLabel.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                             constant: leftOffset).isActive = true
        voteNotifSwitch.topAnchor.constraint(equalTo: voteNotifLabel.topAnchor).isActive = true
        voteNotifSwitch.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        eliminationNotifLabel.topAnchor.constraint(equalTo: voteNotifLabel.bottomAnchor,
                                                   constant: verticalSpacing).isActive = true
        eliminationNotifLabel.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                             constant: leftOffset).isActive = true
        eliminationNotifSwitch.topAnchor.constraint(equalTo: eliminationNotifLabel.topAnchor).isActive = true
        eliminationNotifSwitch.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }

    // MARK: - Event listeners
    @objc
    func switchChanged() {
        print("TODO: Save settings (voteNotif=\(voteNotifSwitch.isOn)," +
              " eliminationNotif=\(eliminationNotifSwitch.isOn))")
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(title: "Notifications")
        voteNotifSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        eliminationNotifSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }
}
