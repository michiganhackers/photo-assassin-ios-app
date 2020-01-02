//
//  BackendCaller.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 9/3/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import Firebase
import FirebaseFunctions
import Foundation

class BackendCaller {
    // MARK: - Private Singletons
    private static let database = Firestore.firestore()
    private static let functions = Functions.functions()

    // MARK: - Nested Types
    enum ClientSideError: Error {
        case badImage
    }

    // MARK: - Public functions
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

    func submitVote(gameID: String, snipeID: String, vote: Bool, callback: @escaping (Error?) -> Void) {
        type(of: self).functions.httpsCallable("submitVote").call([
            "gameID": gameID,
            "snipeID": snipeID,
            "vote": vote
        ]) { _ /*result*/, error in
            callback(error)
        }
    }

    func leaveGame(gameID: String, callback: @escaping (Error?) -> Void) {
        type(of: self).functions.httpsCallable("leaveGame").call([
            "gameID": gameID
        ]) { _ /* result */, error in
            callback(error)
        }
    }
    func addUser(displayName: String, callback: @escaping (String?, Error?) -> Void) {
        type(of: self).functions.httpsCallable("addUser").call([
            "displayName": displayName
        ]) { result, error in
            callback((result?.data as? [String: Any])?["displayName"] as? String,
                     error)
        }
    }
    func player(fromUID uid: String, completionHandler: @escaping (Player?) -> Void) {
        let userRef = type(of: self).database.collection("users").document(uid)
        userRef.getDocument { user, error in
            if let error = error {
                print("Error retrieving player: \(error)")
                completionHandler(nil)
                return
            }
            guard let user = user else {
                print("Could not retrieve player")
                completionHandler(nil)
                return
            }
            let username = user.get("displayName") as? String ?? ""
            let profilePic = user.get("profilePicUrl") as? String ?? ""
            var relationship: Player.Relationship = .none
            if uid == Auth.auth().currentUser?.uid {
                completionHandler(Player(
                    uid: uid,
                    username: username,
                    relationship: .myself,
                    profilePicture: profilePic
                ))
                return
            }
            userRef.collection("friends").getDocuments { friends, error in
                if let error = error {
                    print("Error retrieving friend list: \(error)")
                    completionHandler(nil)
                    return
                }
                for friend in friends?.documents ?? [] {
                    if friend.documentID == Auth.auth().currentUser?.uid {
                        relationship = .friend
                        break
                    }
                }
                completionHandler(Player(
                    uid: uid,
                    username: username,
                    relationship: relationship,
                    profilePicture: profilePic
                ))
            }
        }
    }
}
