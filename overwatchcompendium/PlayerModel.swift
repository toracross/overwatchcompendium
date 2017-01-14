//
//  PlayerModel.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/13/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire

class PlayerModel {
    
    //Player Selected Data
    var selectedRegion = UserDefaults.standard.string(forKey: "playerRegion")!
    var selectedPlatform = UserDefaults.standard.string(forKey: "playerPlatform")!
    var playerName = UserDefaults.standard.string(forKey: "playerName")!
    
    //Overall Stats
    private var _tier: String!
    private var _level: Int!
    private var _compRank: Int!
    private var _prestige: Int!
    private var _avatar: String!
    
    //Overall Stats - Quickplay
    private var _winsQP: Int!
    
    //Overall Stats - Competitive
    private var _winsCP: Int!
    private var _losses: Int!
    private var _ties: Int!
    private var _games: Int!
    private var _winRate: Int!
    
    var tier: String {
        if _tier == nil {
            _tier = "Empty"
        }
        return _tier
    }
    
    var level: Int {
        if _level == nil {
            _level = 0
        }
        return _level
    }
    
    var compRank: Int {
        if _compRank == nil {
            _compRank = 0
        }
        return _compRank
    }
    
    var prestige: Int {
        if _prestige == nil {
            _prestige = 0
        }
        return _prestige
    }
    
    var avatar: String {
        if _avatar == nil {
            _avatar = "Empty"
        }
        return _avatar
    }
    
    var winsQP: Int {
        if _winsQP == nil {
            _winsQP = 0
        }
        return _winsQP
    }
    
    var winsCP: Int {
        if _winsCP == nil {
            _winsCP = 0
        }
        return _winsCP
    }
    
    var losses: Int {
        if _losses == nil {
            _losses = 0
        }
        return _losses
    }
    
    var ties: Int {
        if _ties == nil {
            _ties = 0
        }
        return _ties
    }
    
    var games: Int {
        if _games == nil {
            _games = 0
        }
        return _games
    }
    
    var winRate: Int {
        if _winRate == nil {
            _winRate = 0
        }
        return _winRate
    }
    
    
    
    func downloadStatsData(completed: @escaping DownloadComplete) {
        let url = "https://toracross.com/api/v3/u/\(playerName)/blob?platform=\(selectedPlatform)"
        
        Alamofire.request(url).responseJSON { response in
            let download = response.result
            
            if let JSON = download.value as? Dictionary<String, AnyObject> {
                
                if let region = JSON["\(self.selectedRegion)"] as? Dictionary<String, AnyObject> {
                    //Downloading all player stats.
                    if let stats = region["stats"] as? Dictionary<String, AnyObject> {
                        
                        
                    }
                }
            }
            completed()
        }
    }
}
