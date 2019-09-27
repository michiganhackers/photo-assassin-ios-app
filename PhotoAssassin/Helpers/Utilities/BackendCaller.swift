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

    enum ClientSideError: Error {
        case badImage
    }

    func createGame(name: String, invitedUsernames: [String], callback: @escaping (String?, Error?) -> Void) {
        type(of: self).functions.httpsCallable("createGame").call([
            "name": name,
            "invitedUsernames": invitedUsernames
        ]) { result, error in
            callback((result?.data as? [String: Any])?["gameID"] as? String, error)
        }
    }

    func startGame(gameID: String, callback: @escaping (String?, Error?) -> Void) {
        type(of: self).functions.httpsCallable("startGame").call([
            "gameID": gameID
        ]) { result, error in
            callback((result?.data as? [String: Any])?["gameID"] as? String, error)
        }
    }

    func submitSnipe(gameIDs: [String], image: UIImage, callback: @escaping (String?, Error?) -> Void) {
        let base64String = image.jpegData(compressionQuality: 1.0)?.base64EncodedString()
        guard let base64JPEG = base64String else {
            callback(nil, ClientSideError.badImage)
            return
        }
        type(of: self).functions.httpsCallable("submitSnipe").call([
            "gameIDs": gameIDs,
            "base64JPEG": base64JPEG
        ]) { result, error in
            callback((result?.data as? [String: Any])?["pictureID"] as? String, error)
        }
    }
    
    func addUser(displayName: String, callback: @escaping
        (String?, Error?) -> Void) {
        type(of: self).functions.httpsCallable("addUser").call([
            "displayName": displayName
        ]) { result, error in
            callback((result?.data as? [String: Any])?["displayName"] as? String,
                     error)
        }
    }
}
