//
//  Player.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import Firebase
import UIKit

class Player {
    let DB = Firestore.firestore()
    // MARK: - Nested types
    enum InvitationStatus {
        case invited
        case notInvited
    }
    enum Relationship {
        case friend
        case myself
        case none
    }
    struct Stats {
        let deaths: Int
        let gamesWon: Int
        let gamesFinished: Int
        let kills: Int
        let percentile: Double

        var killDeathRatio: Double {
            return Double(kills) / Double(deaths)
        }
        var winPercentage: Double {
            return Double(gamesWon) / Double(gamesFinished)
        }
    }

    // MARK: - Static members
    static var myself = Player(
        username: "hi_there_its_me",
        relationship: .myself,
        stats: Stats(
            deaths: 8,
            gamesWon: 1,
            gamesFinished: 9,
            kills: 19,
            percentile: 0.57
        )
    )

    // MARK: - Public member functions
    func canAddAsFriend() -> Bool {
        return relationship == .none
    }

    func loadFriends(completionHandler: ([Player]) -> Void) {
        // TODO: Grab friends from Firebase based on username
        let friends = [
            Player(username: "dummy_friend_1", relationship: .friend),
            Player(username: "dummy_2_me", relationship: .myself),
            Player(username: "dummy_3...", relationship: .none)
        ]
        self.friends = friends
        completionHandler(friends)
    }

    func loadGameHistory(completionHandler: @escaping ([GameStats]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Error: Could not obtain current UID")
            completionHandler([])
            return
        }
        var gameStatsArray: [GameStats] = []
        //users -> completedGames REFERENCING
        let playerGameHistory = DB.collection("users").document(uid).collection("completedGames")

        //users -> completedGames RETRIEVING
        playerGameHistory.getDocuments { history, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let history = history else {
                    print("Error getting history")
                    return
                }
                //LOOPING through each game ID
                for currGame in history.documents {
                    //RETRIEVING game object from "games" using gameID
                    let game = self.DB.collection("games").document(currGame.documentID)

                    var kills = -1
                    var place = -1
                    var isOwner = false
                    var didEnd = false
                    //RETRIEVING player's data in the current game.
                    let player = game.collection("players").document(uid)
                    player.getDocument { document, error in
                        guard let document = document, document.exists else {
                            print("Error getting player document for game \(currGame)")
                            if let error = error {
                                print("  (error: \(error))")
                            }
                            return
                        }
                        kills = document.get("kills") as? Int ?? -1
                        place = document.get("place") as? Int ?? -1
                        game.getDocument { document, error in
                            if let error = error {
                                print("Error in retrieving document: \(error)")
                                return
                            }
                            guard let document = document, document.exists else {
                                print("Could not retrieve document")
                                return
                            }
                            if document.get("status") as? String == "ended" {
                                didEnd = true
                            }
                            let gameTitle = document.get("name") as? String
                            let gameInfo = GameStats(
                                game: GameLobby(
                                    id: game.documentID,
                                    title: gameTitle ?? "",
                                    numberInLobby: 0
                                ),
                                kills: kills,
                                place: place,
                                didGameEnd: didEnd
                            )
                            gameStatsArray.append(gameInfo)
                            self.gameHistory = gameStatsArray
                            if gameStatsArray.count == history.documents.count {
                                self.gameHistory = gameStatsArray
                                completionHandler(gameStatsArray)
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Public members
    var username: String
    var relationship: Relationship
    var profilePicture: UIImage?
    var stats: Stats?

    var friends: [Player]?
    var gameHistory: [GameStats]?

    // MARK: - Initializers
    // NOTE: Be careful to avoid reference loops with the array of friends.
    init(username: String,
         relationship: Relationship,
         profilePicture: UIImage? = nil,
         stats: Stats? = nil
    ) {
        self.username = username
        self.relationship = relationship
        self.profilePicture = profilePicture
        self.stats = stats
    }
}
