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
            "invitedUsernames": invitedUsernames,
            "maxPlayers": 10
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
    func addUser(displayName: String, username: String, callback: @escaping (String?, Error?) -> Void) {
        type(of: self).functions.httpsCallable("addUser").call([
            "displayName": displayName,
            "username": username
            
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
            let deaths = user.get("deaths") as? Int ?? -1
            let kills = user.get("kills") as? Int ?? -1
            let stats = Player.Stats( deaths: deaths, gamesWon: -1, gamesFinished: -1, kills: kills, percentile: 50)
            var relationship: Player.Relationship = .none
            if uid == Auth.auth().currentUser?.uid {
                completionHandler(Player(
                    uid: uid,
                    username: username,
                    relationship: .myself,
                    profilePicture: profilePic,
                    stats: stats
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
                    profilePicture: profilePic,
                    stats: stats
                ))
            }
        }
    }

    func gameStats(
        in game: GameLobby,
        from playerDocument: DocumentSnapshot,
        gameStatus: String
    ) -> GameStats {
        var stats: GameStats
        if gameStatus == "notStarted" {
            stats = GameStats(game: game)
        } else if gameStatus == "started" {
            let kills = playerDocument.get("kills") as? Int ?? -1
            let place = playerDocument.get("place") as? Int
            stats = GameStats(game: game, kills: kills, place: place, didGameEnd: false)
        } else { // gameStatus == "ended"
            let kills = playerDocument.get("kills") as? Int ?? -1
            let place = playerDocument.get("place") as? Int ?? -1
            stats = GameStats(game: game, kills: kills, place: place, didGameEnd: true)
        }
        return stats
    }

    func playerWithStatus(
        for player: Player,
        in game: GameLobby,
        from playerDocument: DocumentSnapshot,
        gameStatus: String,
        focused: Player
    ) -> LobbyInfo.PlayerWithStatus {
        let alive = playerDocument.get("alive") as? Bool ?? false
        let isTarget = playerDocument.get("target") as? String == focused.uid

        var relationship: LobbyInfo.GameRelationship
        if !alive {
            relationship = .dead
        } else if isTarget {
            relationship = .target
        } else {
            relationship = .neutral
        }

        return LobbyInfo.PlayerWithStatus(
            player: player,
            relationship: relationship,
            stats: gameStats(in: game, from: playerDocument, gameStatus: gameStatus)
        )
    }
    func playerWithStatus(for player: Player,
                          in game: GameLobby,
                          gameStatus: String,
                          focused: Player,
                          completionHandler: @escaping (LobbyInfo.PlayerWithStatus?) -> Void
    ) {
        let gameRef = type(of: self).database.collection("games").document(game.id)
        gameRef.collection("players").document(player.uid).getDocument { doc, error in
            if let error = error {
                print("Error retrieving player with statuses: \(error)")
                completionHandler(nil)
                return
            }
            guard let doc = doc else {
                print("Could not retrieve player with statuses")
                completionHandler(nil)
                return
            }
            completionHandler(self.playerWithStatus(
                for: player,
                in: game,
                from: doc,
                gameStatus: gameStatus,
                focused: focused
            ))
        }
    }
    func lobbyInfo(
        for game: GameLobby,
        focused: Player,
        completionHandler: @escaping (LobbyInfo?) -> Void
    ) {
        let gameRef = type(of: self).database.collection("games").document(game.id)
        gameRef.getDocument { gameDoc, error in
            guard error == nil, let gameDoc = gameDoc else {
                print("Error retrieving game: \(error as Any? ?? "")")
                completionHandler(nil)
                return
            }
            let gameStatus = gameDoc.get("status") as? String ?? ""
            let start = gameDoc.get("startTime") as? Timestamp
            let end = gameDoc.get("endTime") as? Timestamp
            gameRef.collection("players").getDocuments { players, error in
                guard error == nil, let players = players else {
                    print("Error retrieving players: \(error as Any? ?? "")")
                    completionHandler(nil)
                    return
                }
                var retrieved = 0
                var toRetrieve = players.count
                var others: [LobbyInfo.PlayerWithStatus] = []
                var focusedPlayer: LobbyInfo.PlayerWithStatus?
                var myselfPermission: LobbyInfo.PlayerPermissionLevel = .viewer
                for playerDoc in players.documents {
                    self.player(fromUID: playerDoc.documentID) { player in
                        if let player = player {
                            let withStatus = self.playerWithStatus(
                                for: player, in: game, from: playerDoc,
                                gameStatus: gameStatus, focused: focused
                            )
                            if withStatus.player.uid == Auth.auth().currentUser?.uid {
                                let isOwner = playerDoc.get("isOwner") as? Bool ?? false
                                myselfPermission = isOwner ? .owner : .participant
                            }
                            if playerDoc.documentID == focused.uid {
                                focusedPlayer = withStatus
                            } else {
                                others.append(withStatus)
                            }
                            retrieved += 1
                        } else {
                            toRetrieve -= 1
                        }
                        if retrieved == toRetrieve {
                            completionHandler(LobbyInfo(
                                gameLobby: game, focusedPlayer: focusedPlayer,
                                myselfPermission: myselfPermission, otherPlayers: others,
                                startDate: start?.dateValue(), endDate: end?.dateValue()
                            ))
                        }
                    }
                }
            }
        }
    }
}
