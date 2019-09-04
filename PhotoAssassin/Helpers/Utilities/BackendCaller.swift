//
//  BackendCaller.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 9/3/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import FirebaseFunctions
import Foundation

class BackendCaller {
    // MARK: - Private Singleton
    private static let functions = Functions.functions()

    func createGame(name: String, invitedUsernames: [String], callback: @escaping (String?, Error?) -> Void) {
        type(of: self).functions.httpsCallable("createGame").call([
            "name": name,
            "invitedUsernames": invitedUsernames
        ]) { result, error in
            callback((result?.data as? [String: Any])?["gameID"] as? String, error)
        }
    }
}
