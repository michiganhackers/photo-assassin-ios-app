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
    let rightOffset: CGFloat = -10.0
    let verticalSpacing: CGFloat = 10.0

    let settings: LocalSettings = {
        let settings = LocalSettings()
        settings.updateFromSaved()
        return settings
    }()
    // MARK: - UI elements
    let gradient = SubsectionGradient()
    let voteNotifSwitch: UISwitch = {
        let theSwitch = NotifSwitch(name: "pendingVote")
        theSwitch.addTarget(self, action: #selector(saveButtonChange(switchIn:)), for: .valueChanged)
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = true
        return theSwitch
    }()
    let eliminationNotifSwitch: UISwitch = {
        let theSwitch = NotifSwitch(name: "someoneEliminated")
        theSwitch.addTarget(self, action: #selector(saveButtonChange(switchIn:)), for: .valueChanged)
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = true
        return theSwitch
    }()
    let eliminatedNotifSwitch: UISwitch = {
        let theSwitch = NotifSwitch(name: "youEliminated")
        theSwitch.addTarget(self, action: #selector(saveButtonChange(switchIn:)), for: .valueChanged)
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = true
        return theSwitch
    }()
    let voteResultNotifSwitch: UISwitch = {
        let theSwitch = NotifSwitch(name: "votingResults")
        theSwitch.addTarget(self, action: #selector(saveButtonChange(switchIn:)), for: .valueChanged)
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = true
        return theSwitch
    }()
    let invitedNotifSwitch: UISwitch = {
        let theSwitch = NotifSwitch(name: "invited")
        theSwitch.addTarget(self, action: #selector(saveButtonChange(switchIn:)), for: .valueChanged)
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = true
        return theSwitch
    }()
    let notifsOnOffSwitch: UISwitch = {
        let theSwitch = NotifSwitch(name: "allNotifs")
        theSwitch.addTarget(self, action: #selector(saveButtonChange(switchIn:)), for: .valueChanged)
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = true
        return theSwitch
    }()
    lazy var switches = [
        "pendingVote": voteNotifSwitch,
        "someoneEliminated": eliminationNotifSwitch,
        "youEliminated": eliminatedNotifSwitch,
        "votingResults": voteResultNotifSwitch,
        "invited": invitedNotifSwitch,
        "allNotifs": notifsOnOffSwitch
    ]

    let notifsOnOffLabel = TranslucentLabel(text: "Turn all notifications on/off", size: largeTextSize)
    let overallLabel = TranslucentLabel(text: "Receive notifications when:", size: largeTextSize)
    let voteNotifLabel = TranslucentLabel(text: "You have a pending vote", size: textSize)
    let eliminationNotifLabel = TranslucentLabel(text: "Someone is eliminated", size: textSize)
    let eliminatedNotifLabel = TranslucentLabel(text: "You are eliminated", size: textSize)
    let voteResultNotifLabel = TranslucentLabel(text: "Voting results are in", size: textSize)
    let invitedNotifLabel = TranslucentLabel(text: "When you are invited", size: textSize)
    let notifsView = UIView()
    // MARK: - Custom methods
    func addSubviews() {
        notifsView.translatesAutoresizingMaskIntoConstraints = false
        //notifsView.backgroundColor = .white
        view.addSubview(notifsView)
        gradient.addToView(notifsView)
        notifsView.addSubview(voteNotifSwitch)
        notifsView.addSubview(eliminationNotifSwitch)
        notifsView.addSubview(eliminatedNotifSwitch)
        notifsView.addSubview(voteResultNotifSwitch)
        notifsView.addSubview(invitedNotifSwitch)
        view.addSubview(overallLabel)
        notifsView.addSubview(voteNotifLabel)
        notifsView.addSubview(eliminationNotifLabel)
        notifsView.addSubview(voteResultNotifLabel)
        notifsView.addSubview(invitedNotifLabel)
        notifsView.addSubview(eliminatedNotifLabel)
        view.addSubview(notifsOnOffLabel)
        view.addSubview(notifsOnOffSwitch)
    }
    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        notifsOnOffLabel.topAnchor.constraint(equalTo: margins.topAnchor,
                                              constant: verticalSpacing).isActive = true
        notifsOnOffLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        notifsOnOffSwitch.topAnchor.constraint(equalTo: notifsOnOffLabel.topAnchor).isActive = true
        notifsOnOffSwitch.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        overallLabel.topAnchor.constraint(equalTo: notifsOnOffLabel.bottomAnchor,
                                          constant: verticalSpacing).isActive = true
        overallLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        voteNotifLabel.topAnchor.constraint(equalTo: overallLabel.bottomAnchor,
                                            constant: verticalSpacing + 20).isActive = true
        voteNotifLabel.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                             constant: leftOffset).isActive = true
        voteNotifSwitch.topAnchor.constraint(equalTo: voteNotifLabel.topAnchor).isActive = true
        voteNotifSwitch.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                               constant: rightOffset).isActive = true
        eliminationNotifLabel.topAnchor.constraint(equalTo: voteNotifLabel.bottomAnchor,
                                                   constant: verticalSpacing).isActive = true
        eliminationNotifLabel.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                             constant: leftOffset).isActive = true
        eliminationNotifSwitch.topAnchor.constraint(equalTo: eliminationNotifLabel.topAnchor).isActive = true
        eliminationNotifSwitch.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                                      constant: rightOffset).isActive = true
        eliminatedNotifLabel.topAnchor.constraint(equalTo: eliminationNotifLabel.bottomAnchor,
                                                  constant: verticalSpacing).isActive = true
        eliminatedNotifLabel.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                                   constant: leftOffset).isActive = true
        eliminatedNotifSwitch.topAnchor.constraint(equalTo: eliminatedNotifLabel.topAnchor).isActive = true
        eliminatedNotifSwitch.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                                     constant: rightOffset).isActive = true
        voteResultNotifLabel.topAnchor.constraint(equalTo: eliminatedNotifLabel.bottomAnchor,
                                                  constant: verticalSpacing).isActive = true
        voteResultNotifLabel.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                                   constant: leftOffset).isActive = true
        voteResultNotifSwitch.topAnchor.constraint(equalTo: voteResultNotifLabel.topAnchor).isActive = true
        voteResultNotifSwitch.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                                     constant: rightOffset).isActive = true
        invitedNotifLabel.topAnchor.constraint(equalTo: voteResultNotifLabel.bottomAnchor,
                                                  constant: verticalSpacing).isActive = true
        invitedNotifLabel.leftAnchor.constraint(equalTo: margins.leftAnchor,
                                                   constant: leftOffset).isActive = true
        invitedNotifSwitch.topAnchor.constraint(equalTo: invitedNotifLabel.topAnchor).isActive = true
        invitedNotifSwitch.rightAnchor.constraint(equalTo: margins.rightAnchor,
                                                  constant: rightOffset).isActive = true
        notifsView.topAnchor.constraint(equalTo: voteNotifLabel.topAnchor,
                                        constant: -verticalSpacing).isActive = true
        notifsView.bottomAnchor.constraint(equalTo: invitedNotifLabel.bottomAnchor,
                                           constant: verticalSpacing).isActive = true
        notifsView.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        notifsView.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        notifsView.layoutIfNeeded()
        gradient.layoutInView(notifsView)
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
        updateAllSwitches(settings1: settings)
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

    @objc
    func saveButtonChange(switchIn: NotifSwitch) {
        if switchIn.name == "allNotifs" {
            settings.updateAllNotifs(allNotif: switchIn.isOn)
            liveChangeAll(allNotifSwitch: switchIn)
        } else {
        settings.notifications[switchIn.name] = switchIn.isOn
        }
        settings.saveAll()
    }

    func updateAllSwitches(settings1: LocalSettings) {
        for (name1, switch1) in switches {
            switch1.isOn = settings1.getSettings(forName: name1)
        }
    }

    func liveChangeAll(allNotifSwitch: NotifSwitch) {
        voteNotifSwitch.setOn(allNotifSwitch.isOn, animated: true)
        eliminationNotifSwitch.setOn(allNotifSwitch.isOn, animated: true)
        eliminatedNotifSwitch.setOn(allNotifSwitch.isOn, animated: true)
        voteResultNotifSwitch.setOn(allNotifSwitch.isOn, animated: true)
        invitedNotifSwitch.setOn(allNotifSwitch.isOn, animated: true)
    }
}
