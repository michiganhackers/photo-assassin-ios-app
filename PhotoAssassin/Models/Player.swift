//
//  Player.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/11/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit
import Firebase

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

    func loadGameHistory(completionHandler: ([GameStats]) -> Void) {
        // TODO: Grab game history from Firebase based on username
        
        //DB reference: user's completed games
        let playerGameHistory = DB.collection("Users").document(Auth.auth().currentUser!.uid).collection("completedGames")
        
        playerGameHistory.getDocuments{ (gameHistory, error) in
            if let error = error{
                print("Error getting documents: \(error)")
            }
            else {
                //Looping through each game.
                for document in gameHistory!.documents{
                    //PARAM: game ID
                    //Retrieve game object from COLLECTION: "Games"
                    let game = self.DB.collection("games").document(document.documentID)
                    
                    //UNUSED
                    let gameUserInfo = game.collection("players").document(Auth.auth().currentUser!.uid)
                    
                    //Retrieving data from game object: Status, Name
                    //Creating an OBJECT: GameStats from data
                    var didEnd : Bool = false;
                    game.getDocument { (gameData, error) in
                        if let gameData = gameData, gameData.exists{
                            if (gameData.get("status") as! String == "ended"){
                                didEnd = true;
                            }
                            let gameTitle = gameData.get("name")
                            let gameInfo = GameStats(game:
                                GameLobby(id: game.documentID,
                                                title:gameTitle as! String, numberInLobby: 0 ),
                                kills: gameData.get("kills") as! Int,
                                place: gameData.get("place") as! Int,
                                didGameEnd: didEnd)
                            //completionHandler(gameInfo)
                        }
                        else{
                            print("Error \(error)")
                        }
                    }
                }
            }
            
        }
        let games = [
            GameStats(game: GameLobby(id: "0ab", title: "Snipefest", numberInLobby: 0),
                      kills: 5, place: 2),
            GameStats(game: GameLobby(id: "1cd", title: "Mhackers xD lolz", numberInLobby: 0),
                      kills: 15, place: 1),
            GameStats(game: GameLobby(id: "2ef", title: "Bonfire Party", numberInLobby: 0),
                      kills: 21, place: 7)
        ]
        self.gameHistory = games
        completionHandler(games)
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
