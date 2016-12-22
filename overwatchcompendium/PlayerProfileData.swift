//
//  PlayerProfileData.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/15/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire

class PlayerProfileData {
    
    //API Data
    let url = UserDefaults.standard.string(forKey: "playerProfile")
    let playerQPStatsUrl = UserDefaults.standard.string(forKey: "playerStatsQP")
    
    //Private Variables
    private var _playerName: String!
    private var _playerAvatar: String!
    private var _playerQPWins: String!
    private var _playerCPWins: String!
    private var _playerQPTime: String!
    private var _playerCPTime: String!
    private var _playerCPLoss: Int!
    private var _playerCPTotal: String!
    private var _playerRank: String!
    private var _playerRankImg: String!
    private var _playerLevel: Int!
    private var _playerLevelImg: String!
    private var _playerStar: String!
    
    //Variables - Access Private
    var playerName: String {
        if _playerName == nil {
            _playerName = "NAME"
        }
        return _playerName
    }
    
    var playerAvatar: String {
        if _playerAvatar == nil {
            _playerAvatar = ""
        }
        return _playerAvatar
    }
    
    var playerQPWins: String {
        if _playerQPWins == nil {
            _playerQPWins = ""
        }
        return _playerQPWins
    }
    
    var playerCPWins: String {
        if _playerCPWins == nil {
            _playerCPWins = "0"
        }
        return _playerCPWins
    }
    
    var playerQPTime: String {
        if _playerQPTime == nil {
            _playerQPTime = ""
        }
        return _playerQPTime
    }
    
    var playerCPTime: String {
        if _playerCPTime == nil {
            _playerCPTime = "0 hours"
        }
        return _playerCPTime
    }
    
    var playerCPLoss: Int {
        if _playerCPLoss == nil {
            _playerCPLoss = 0
        }
        return _playerCPLoss
    }
    
    var playerCPTotal: String {
        if _playerCPTotal == nil {
            _playerCPTotal = ""
        }
        return _playerCPTotal
    }
    
    var playerRank: String {
        if _playerRank == nil {
            _playerRank = "None"
        }
        return _playerRank
    }
    
    var playerRankImg: String {
        if _playerRankImg == nil {
            _playerRankImg = ""
        }
        return _playerRankImg
    }
    
    var playerLevel: Int {
        if _playerLevel == nil {
            _playerLevel = 0
        }
        return _playerLevel
    }
    
    var playerLevelImg: String {
        if _playerLevelImg == nil {
            _playerLevelImg = ""
        }
        return _playerLevelImg
    }
    
    var playerStar: String {
        if _playerStar == nil {
            _playerStar = ""
        }
        return _playerStar
    }
    
    
    //Parse API Data
    func downloadPlayerStats(completed: @escaping DownloadComplete) {
        Alamofire.request(url!).responseJSON { response in
            let errorCode = response.response?.statusCode
            let download = response.result
            if errorCode != 404 {
                if let JSON = download.value as? Dictionary<String, AnyObject> {
                    
                    if let data = JSON["data"] as? Dictionary<String, AnyObject> {
                        
                        if let username = data["username"] as? String {
                            self._playerName = username
                        }
                        if let level = data["level"] as? Int {
                            self._playerLevel = level
                        }
                        
                        if let competitive = data["competitive"] as? Dictionary<String, AnyObject> {
                            if let rank = competitive["rank"] as? String {
                                self._playerRank = rank
                            }
                            if let rankImg = competitive["rank_img"] as? String {
                                self._playerRankImg = rankImg
                            }
                        }
                        
                        if let playtime = data["playtime"] as? Dictionary<String, AnyObject> {
                            if let quick = playtime["quick"] as? String {
                                self._playerQPTime = quick
                            }
                            if let competitive = playtime["competitive"] as? String {
                                self._playerCPTime = competitive
                            }
                        }
                        
                        if let games = data["games"] as? Dictionary<String, AnyObject> {
                            if let quickplay = games["quick"] as? Dictionary<String, AnyObject> {
                                if let wins = quickplay["wins"] as? String {
                                    self._playerQPWins = wins
                                }
                            }
                            if let competitive = games["competitive"] as? Dictionary<String, AnyObject> {
                                if let wins = competitive["wins"] as? String {
                                    self._playerCPWins = wins
                                }
                                if let lost = competitive["lost"] as? Int {
                                    self._playerCPLoss = lost
                                }
                                if let total = competitive["played"] as? String {
                                    self._playerCPTotal = total
                                }
                            }
                        }
                        
                        if let avatar = data["avatar"] as? String {
                            self._playerAvatar = avatar
                            
                        }
                        
                        if let levelFrame = data["levelFrame"] as? String {
                            self._playerLevelImg = levelFrame
                        }
                        
                        if let star = data["star"] as? String {
                            self._playerStar = star
                            
                        }
                        
                    }
                    
                }
                completed()
            } else {
                print("Could not download data.")
            }
            
        }

    }
}
