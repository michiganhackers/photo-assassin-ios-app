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
        var gameStatsArray = [GameStats]()
        
        //users -> completedGames REFERENCING
        let playerGameHistory = DB.collection("users").document(Auth.auth().currentUser!.uid).collection("completedGames")
        print("Game ID successfully retrieved")
        
        //users -> completedGames RETRIEVING
        playerGameHistory.getDocuments{ (gameHistory, error) in
            if let error = error{
                print("Error getting documents: \(error)")
            }
            else {
                //LOOPING through each game ID
                
                for document in gameHistory!.documents{
                    //games -> gameID RETRIEVING
                    let game = self.DB.collection("games").document(document.documentID)
                    print("Game object ID = \(document.documentID)")
                    
                    var kills: Int?
                    var place: Int?
                   
                    let gameUserInfo = game.collection("players").document(Auth.auth().currentUser!.uid)
                    print(gameUserInfo.documentID)
                    //TODO: gameUserInfoData is not getting pulled. kills and place are nil
                    gameUserInfo.getDocument(source: .cache){(gameUserInfoData, error) in
                        if let gameUserInfoData = gameUserInfoData, gameUserInfoData.exists
                        {
                            kills = gameUserInfoData.get("kills") as? Int
                            place = gameUserInfoData.get("field") as? Int
                        }
                    }
                    print(kills)
                    print(place)
                    //Retrieving data from game object: Status, Name
                    //Creating an OBJECT: GameStats from data
                    var didEnd : Bool = false;
                    game.getDocument { (gameData, error) in
                        if let gameData = gameData, gameData.exists{
                            if (gameData.get("status") as? String == "ended"){
                                didEnd = true;
                            }
                            guard let gameTitle = gameData.get("name") as? String else { return }
                            let gameInfo = GameStats(game:
                                GameLobby(id: game.documentID,
                                                title: gameTitle,
                                                numberInLobby: 0),
                                                kills: kills,
                                                place: place,
                                                didGameEnd: didEnd)

                            //completionHandler(gameInfo)
                            gameStatsArray.append(gameInfo)
                            print("DATA COLLECTION SUCCESSFUL :)")
                        }
                        else{
                            print("Error \(error)")
                        }
                    }
                    
                }
            }
            
        }

        /*
        let games = [
            GameStats(game: GameLobby(id: "0ab", title: "Snipefest", numberInLobby: 0),
                      kills: 5, place: 2),
            GameStats(game: GameLobby(id: "1cd", title: "Mhackers xD lolz", numberInLobby: 0),
                      kills: 15, place: 1),
            GameStats(game: GameLobby(id: "2ef", title: "Bonfire Party", numberInLobby: 0),
                      kills: 21, place: 7)
        ]*/
        self.gameHistory = gameStatsArray;
        completionHandler(gameStatsArray)
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
