//
//  NotificationSettings.swift
//  PhotoAssassin
//
//  Created by Alex Wang on 10/17/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import Foundation

class LocalSettings {
    var allNotifs = false
    var notifications: [String: Bool] = [
        "pendingVote": false,
        "someoneEliminated": false,
        "youEliminated": false,
        "votingResults": false,
        "invited": false
    ]

    func updateAllNotifs(allNotif: Bool) {
        allNotifs = allNotif
        for (notif, _) in notifications {
            notifications[notif] =  allNotif
        }
    }

    func saveAll() {
        var allOn = true
        for (notif, isOn) in notifications {
            UserDefaults.standard.set(isOn, forKey: notif)
            if !isOn {
                allOn = false
            }
        }
        allNotifs = allOn
        UserDefaults.standard.set(allNotifs, forKey: "allNotifs")
    }

    func updateFromSaved() {
        allNotifs = UserDefaults.standard.bool(forKey: "allNotifs")
        for (notif, _) in notifications {
            notifications[notif] = UserDefaults.standard.bool(forKey: notif)
        }
    }

    func getSettings(forName: String) -> Bool {
        if forName == "allNotifs" {
            return allNotifs
        }
        return notifications[forName] ?? false
    }
}
