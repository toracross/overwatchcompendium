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
    
    //Quickplay Average Stats
    
    private var _deathsAvgQP: Double!
    private var _soloKillsAvgQP: Double!
    private var _eliminationsAvgQP: Double!
    private var _damageDoneAvgQP: Double!
    private var _finalBlowsAvgQP: Double!
    private var _reconAssistsAvgQP: Double!
    private var _objectiveKillsAvgQP: Double!
    private var _objectiveTimeAvgQP: Double!
    private var _defensiveAssistsAvgQP: Double!
    private var _timeSpentOnFireAvgQP: Double!
    private var _offensiveAssistsAvgQP: Double!
    private var _healingDoneAvgQP: Double!
    private var _meleeFinalBlowsAvgQP: Double!
    
    var deathsAvgQP: Double {
        if _deathsAvgQP == nil {
            _deathsAvgQP = 0
        }
        return _deathsAvgQP
    }
    
    var soloKillsAvgQP: Double {
        if _soloKillsAvgQP == nil {
            _soloKillsAvgQP = 0
        }
        return _soloKillsAvgQP
    }
    
    var eliminationsAvgQP: Double {
        if _eliminationsAvgQP == nil {
            _eliminationsAvgQP = 0
        }
        return _eliminationsAvgQP
    }
    
    var damageDoneAvgQP: Double {
        if _damageDoneAvgQP == nil {
            _damageDoneAvgQP = 0
        }
        return _damageDoneAvgQP
    }
    
    var finalBlowsAvgQP: Double {
        if _finalBlowsAvgQP == nil {
            _finalBlowsAvgQP = 0
        }
        return _finalBlowsAvgQP
    }
    
    var reconAssistsAvgQP: Double {
        if _reconAssistsAvgQP == nil {
            _reconAssistsAvgQP = 0
        }
        return _reconAssistsAvgQP
    }
    
    var objectiveKillsAvgQP: Double {
        if _objectiveKillsAvgQP == nil {
            _objectiveKillsAvgQP = 0
        }
        return _objectiveKillsAvgQP
    }
    
    var objectiveTimeAvgQP: Double {
        if _objectiveTimeAvgQP == nil {
            _objectiveTimeAvgQP = 0
        }
        return _objectiveTimeAvgQP
    }
    
    var defensiveAssistsAvgQP: Double {
        if _defensiveAssistsAvgQP == nil {
            _defensiveAssistsAvgQP = 0
        }
        return _defensiveAssistsAvgQP
    }
    
    var timeSpentOnFireAvgQP: Double {
        if _timeSpentOnFireAvgQP == nil {
            _timeSpentOnFireAvgQP = 0
        }
        return _timeSpentOnFireAvgQP
    }
    
    var offensiveAssistsAvgQP: Double {
        if _offensiveAssistsAvgQP == nil {
            _offensiveAssistsAvgQP = 0
        }
        return _offensiveAssistsAvgQP
    }
    
    var healingDoneAvgQP: Double {
        if _healingDoneAvgQP == nil {
            _healingDoneAvgQP = 0
        }
        return _healingDoneAvgQP
    }
    
    var meleeFinalBlowsAvgQP: Double {
        if _meleeFinalBlowsAvgQP == nil {
            _meleeFinalBlowsAvgQP = 0
        }
        return _meleeFinalBlowsAvgQP
    }
    
    
    //Competitive Average Stats
    
    private var _deathsAvgCP: Double!
    private var _soloKillsAvgCP: Double!
    private var _eliminationsAvgCP: Double!
    private var _damageDoneAvgCP: Double!
    private var _finalBlowsAvgCP: Double!
    private var _reconAssistsAvgCP: Double!
    private var _objectiveKillsAvgCP: Double!
    private var _objectiveTimeAvgCP: Double!
    private var _defensiveAssistsAvgCP: Double!
    private var _timeSpentOnFireAvgCP: Double!
    private var _offensiveAssistsAvgCP: Double!
    private var _healingDoneAvgCP: Double!
    private var _meleeFinalBlowsAvgCP: Double!
    
    
    var deathsAvgCP: Double {
        if _deathsAvgCP == nil {
            _deathsAvgCP = 0
        }
        return _deathsAvgCP
    }
    
    var soloKillsAvgCP: Double {
        if _soloKillsAvgCP == nil {
            _soloKillsAvgCP = 0
        }
        return _soloKillsAvgCP
    }
    
    var eliminationsAvgCP: Double {
        if _eliminationsAvgCP == nil {
            _eliminationsAvgCP = 0
        }
        return _eliminationsAvgCP
    }
    
    var damageDoneAvgCP: Double {
        if _damageDoneAvgCP == nil {
            _damageDoneAvgCP = 0
        }
        return _damageDoneAvgCP
    }
    
    var finalBlowsAvgCP: Double {
        if _finalBlowsAvgCP == nil {
            _finalBlowsAvgCP = 0
        }
        return _finalBlowsAvgCP
    }
    
    var reconAssistsAvgCP: Double {
        if _reconAssistsAvgCP == nil {
            _reconAssistsAvgCP = 0
        }
        return _reconAssistsAvgCP
    }
    
    var objectiveKillsAvgCP: Double {
        if _objectiveKillsAvgCP == nil {
            _objectiveKillsAvgCP = 0
        }
        return _objectiveKillsAvgCP
    }
    
    var objectiveTimeAvgCP: Double {
        if _objectiveTimeAvgCP == nil {
            _objectiveTimeAvgCP = 0
        }
        return _objectiveTimeAvgCP
    }
    
    var defensiveAssistsAvgCP: Double {
        if _defensiveAssistsAvgCP == nil {
            _defensiveAssistsAvgCP = 0
        }
        return _defensiveAssistsAvgCP
    }
    
    var timeSpentOnFireAvgCP: Double {
        if _timeSpentOnFireAvgCP == nil {
            _timeSpentOnFireAvgCP = 0
        }
        return _timeSpentOnFireAvgCP
    }
    
    var offensiveAssistsAvgCP: Double {
        if _offensiveAssistsAvgCP == nil {
            _offensiveAssistsAvgCP = 0
        }
        return _offensiveAssistsAvgCP
    }
    
    var healingDoneAvgCP: Double {
        if _healingDoneAvgCP == nil {
            _healingDoneAvgCP = 0
        }
        return _healingDoneAvgCP
    }
    
    var meleeFinalBlowsAvgCP: Double {
        if _meleeFinalBlowsAvgCP == nil {
            _meleeFinalBlowsAvgCP = 0
        }
        return _meleeFinalBlowsAvgCP
    }
    
    //Quickplay Game Stats
    
    
    func downloadStatsData(completed: @escaping DownloadComplete) {
        let url = "https://toracross.com/api/v3/u/\(playerName)/blob?platform=\(selectedPlatform)"
        
        Alamofire.request(url).responseJSON { response in
            let download = response.result
            
            if let JSON = download.value as? Dictionary<String, AnyObject> {
                
                if let region = JSON["\(self.selectedRegion)"] as? Dictionary<String, AnyObject> {
                    
                    //Downloading all player achievements.
                    if let achievements = region["achievements"] as? Dictionary<String, AnyObject> {
                        
                    }
                    
                    //Downloading all player stats.
                    if let stats = region["stats"] as? Dictionary<String, AnyObject> {
                        
                    }
                    
                    //Downloading all player Hero Data
                    if let heroes = region["heroes"] as? Dictionary<String, AnyObject> {
                        
                    }
                    
                }
            }
            completed()
        }
    }
}
