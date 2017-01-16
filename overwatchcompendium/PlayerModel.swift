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
    
    //Achievements
    
    private var _defense: [String: AnyObject]!
    private var _general: [String: AnyObject]!
    private var _maps: [String: AnyObject]!
    private var _offense: [String: AnyObject]!
    private var _special: [String: AnyObject]!
    private var _support: [String: AnyObject]!
    private var _tank: [String: AnyObject]!
    
    var defense: [String: AnyObject] {
        if _defense == nil {
            _defense = [:]
        }
        return _defense
    }
    
    var general: [String: AnyObject] {
        if _general == nil {
            _general = [:]
        }
        return _general
    }
    
    var maps: [String: AnyObject] {
        if _maps == nil {
            _maps = [:]
        }
        return _maps
    }
    
    var offense: [String: AnyObject] {
        if _offense == nil {
            _offense = [:]
        }
        return _offense
    }
    
    var special: [String: AnyObject] {
        if _special == nil {
            _special = [:]
        }
        return _special
    }
    
    var support: [String: AnyObject] {
        if _support == nil {
            _support = [:]
        }
        return _support
    }
    
    var tank: [String: AnyObject] {
        if _tank == nil {
            _tank = [:]
        }
        return _tank
    }
    
    //Heroes
    //Playtime
    private var _playtimeQP: [String: Double]!
    private var _playtimeCP: [String: Double]!
    
    var playtimeQP: [String: Double] {
        if _playtimeQP == nil {
            _playtimeQP = [:]
        }
        return _playtimeQP
    }
    
    var playtimeCP: [String: Double] {
        if _playtimeCP == nil {
            _playtimeCP = [:]
        }
        return _playtimeCP
    }
    
    //Hero Stats
    
    private var _heroQPStats: [String: AnyObject]!
    private var _heroCPStats: [String: AnyObject]!
    
    var heroQPStats: [String: AnyObject] {
        if _heroQPStats == nil {
            _heroQPStats = [:]
        }
        return _heroQPStats
    }
    
    var heroCPStats: [String : AnyObject] {
        if _heroCPStats == nil {
            _heroCPStats = [:]
        }
        return _heroCPStats
    }
    
    //Stats
    
    //Stats
    //Quickplay
    private var _averageStatsQP: [String: Int]!
    private var _gameStatsQP: [String: AnyObject]!
    private var _overallStatsQP: [String: AnyObject]!
    
    //Competitive
    private var _averageStatsCP: [String: AnyObject]!
    private var _gameStatsCP: [String: AnyObject]!
    private var _overallStatsCP: [String: AnyObject]!
    
    var averageStatsQP: [String: Int] {
        if _averageStatsQP == nil {
            _averageStatsQP = [:]
        }
        return _averageStatsQP
    }
    
    var gameStatsQP: [String: AnyObject] {
        if _gameStatsQP == nil {
            _gameStatsQP = [:]
        }
        return _gameStatsQP
    }
    
    var overallStatsQP: [String: AnyObject] {
        if _overallStatsQP == nil {
            _overallStatsQP = [:]
        }
        return _overallStatsQP
    }
    
    var averageStatsCP: [String: AnyObject] {
        if _averageStatsCP == nil {
            _averageStatsCP = [:]
        }
        return _averageStatsCP
    }
    
    var gameStatsCP: [String: AnyObject] {
        if _gameStatsCP == nil {
            _gameStatsCP = [:]
        }
        return _gameStatsCP
    }
    
    var overallStatsCP: [String: AnyObject] {
        if _overallStatsCP == nil {
            _overallStatsCP = [:]
        }
        return _overallStatsCP
    }
    
    
    //Download ALL of the data!
    func downloadStatsData(completed: @escaping DownloadComplete) {
        let url = "https://toracross.com/api/v3/u/\(playerName)/blob?platform=\(selectedPlatform)"
        
        Alamofire.request(url).responseJSON { response in
            let download = response.result
            
            if let JSON = download.value as? Dictionary<String, AnyObject> {
                
                if let region = JSON["\(self.selectedRegion)"] as? Dictionary<String, AnyObject> {
                    
                    //Downloading all player achievements.
                    if let achievements = region["achievements"] as? Dictionary<String, AnyObject> {
                        //Defense
                        if let defense = achievements["defense"] as? [String: AnyObject] {
                            self._defense = defense
                        }
                        //General
                        if let general = achievements["general"] as? [String: AnyObject] {
                            self._general = general
                        }
                        //Maps
                        if let maps = achievements["maps"] as? [String: AnyObject] {
                            self._maps = maps
                        }
                        //Offense
                        if let offense = achievements["offense"] as? [String: AnyObject] {
                            self._offense = offense
                        }
                        //Special
                        if let special = achievements["special"] as? [String: AnyObject] {
                            self._special = special
                        }
                        //Support
                        if let support = achievements["support"] as? [String: AnyObject] {
                            self._support = support
                        }
                        //Tank
                        if let defense = achievements["defense"] as? [String: AnyObject] {
                            self._defense = defense
                        }
                    }
                    
                    //Downloading all player Hero Data
                    if let heroes = region["heroes"] as? Dictionary<String, AnyObject> {
                        
                        //Playtime
                        if let playtime = heroes["playtime"] as? Dictionary<String, AnyObject> {
                            if let quickplay = playtime["quickplay"] as? [String: Double] {
                                self._playtimeQP = quickplay
                            }
                            
                            if let competitive = playtime["competitive"] as? [String: Double] {
                                self._playtimeCP = competitive
                            }
                        }
                        
                        //Stats
                        if let stats = heroes["stats"] as? Dictionary<String, AnyObject> {
                            
                            if let quickplay = stats["quickplay"] as? [String: AnyObject] {
                                self._heroQPStats = quickplay
                            }
                            
                            if let competitive = stats["competitive"] as? [String: AnyObject] {
                                self._heroCPStats = competitive
                            }
                        }
                    }
                    
                    //Downloading all player stats.
                    if let stats = region["stats"] as? Dictionary<String, AnyObject> {
                        
                        //Quickplay
                        if let quickplay = stats["quickplay"] as? Dictionary<String, AnyObject> {
                            //Overall Stats
                            if let overallStats = quickplay["overall_stats"] as? Dictionary<String, AnyObject> {
                                self._overallStatsQP = overallStats
                            }
                            //Average Stats
                            if let averageStats = quickplay["average_stats"] as? Dictionary<String, Int> {
                                self._averageStatsQP = averageStats
                            }
                            //Game Stats
                            if let gameStats = quickplay["game_stats"] as? Dictionary<String, AnyObject> {
                                self._gameStatsQP = gameStats
                            }
                        }
                        
                        //Competitive
                        if let competitive = stats["competitive"] as? Dictionary<String, AnyObject> {
                            //Overall Stats
                            if let overallStats = competitive["overall_stats"] as? Dictionary<String, AnyObject> {
                                self._overallStatsCP = overallStats
                            }
                            //Average Stats
                            if let averageStats = competitive["average_stats"] as? Dictionary<String, AnyObject> {
                                self._averageStatsCP = averageStats
                            }
                            //Game Stats
                            if let gameStats = competitive["game_stats"] as? Dictionary<String, AnyObject> {
                                self._gameStatsCP = gameStats
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
}
