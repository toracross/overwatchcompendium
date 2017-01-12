//
//  PlayerStatsQP.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/22/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//
import UIKit
import Alamofire

class PlayerStatsQP {
    
    //Combat
    private var _meleeFinalBlows: String!
    private var _soloKills: String!
    private var _objectiveKills: String!
    private var _finalBlows: String!
    private var _damageDone: String!
    private var _eliminations: String!
    private var _environmentalKills: String!
    private var _multikills: String!
    
    var meleeFinalBlows: String {
        if _meleeFinalBlows == nil {
            _meleeFinalBlows = "0"
        }
        return _meleeFinalBlows
    }
    
    var soloKills: String {
        if _soloKills == nil {
            _soloKills = "0"
        }
        return _soloKills
    }
    
    var objectiveKills: String {
        if _objectiveKills == nil {
            _objectiveKills = "0"
        }
        return _objectiveKills
    }
    
    var finalBlows: String {
        if _finalBlows == nil {
            _finalBlows = "0"
        }
        return _finalBlows
    }
    
    var damageDone: String {
        if _damageDone == nil {
            _damageDone = "0"
        }
        return _damageDone
    }
    
    var eliminations: String {
        if _eliminations == nil {
            _eliminations = "0"
        }
        return _eliminations
    }
    
    var environmentalKills: String {
        if _environmentalKills == nil {
            _environmentalKills = "0"
        }
        return _environmentalKills
    }
    
    var multikills: String {
        if _multikills == nil {
            _multikills = "0"
        }
        return _multikills
    }
    
    //Assists
    private var _reconAssists: String!
    private var _healingDone: String!
    private var _teleporterPadsDestroyed: String!
    
    var reconAssists: String {
        if _reconAssists == nil {
            _reconAssists = "0"
        }
        return _reconAssists
    }
    
    var healingDone: String {
        if _healingDone == nil {
            _healingDone = "0"
        }
        return _healingDone
    }
    
    var teleporterPadsDestroyed: String {
        if _teleporterPadsDestroyed == nil {
            _teleporterPadsDestroyed = "0"
        }
        return _teleporterPadsDestroyed
    }
    
    //Best
    private var _eliminationsMostInGame: String!
    private var _finalBlowsMostInGame: String!
    private var _damageDoneMostInGame: String!
    private var _healingDoneMostInGame: String!
    private var _defensiveAssistsMostInGame: String!
    private var _offensiveAssistsMostInGame: String!
    private var _objectiveKillsMostInGame: String!
    private var _objectiveTimeMostInGame: String!
    private var _multikillBest: String!
    private var _soloKillsMostInGame: String!
    private var _timeSpentOnFireMostInGame: String!
    
    var eliminationsMostInGame: String {
        if _eliminationsMostInGame == nil {
            _eliminationsMostInGame = "0"
        }
        return _eliminationsMostInGame
    }
    
    var finalBlowsMostInGame: String {
        if _finalBlowsMostInGame == nil {
            _finalBlowsMostInGame = "0"
        }
        return _finalBlowsMostInGame
    }
    
    var damageDoneMostInGame: String {
        if _damageDoneMostInGame == nil {
            _damageDoneMostInGame = "0"
        }
        return _damageDoneMostInGame
    }
    
    var healingDoneMostInGame: String {
        if _healingDoneMostInGame == nil {
            _healingDoneMostInGame = "0"
        }
        return _healingDoneMostInGame
    }
    
    var defensiveAssistsMostInGame: String {
        if _defensiveAssistsMostInGame == nil {
            _defensiveAssistsMostInGame = "0"
        }
        return _defensiveAssistsMostInGame
    }
    
    var offensiveAssistsMostInGame: String {
        if _offensiveAssistsMostInGame == nil {
            _offensiveAssistsMostInGame = "0"
        }
        return _offensiveAssistsMostInGame
    }
    
    var objectiveKillsMostInGame: String {
        if _objectiveKillsMostInGame == nil {
            _objectiveKillsMostInGame = "0"
        }
        return _objectiveKillsMostInGame
    }
    
    var objectiveTimeMostInGame: String {
        if _objectiveTimeMostInGame == nil {
            _objectiveTimeMostInGame = "0"
        }
        return _objectiveTimeMostInGame
    }
    
    var multikillBest: String {
        if _multikillBest == nil {
            _multikillBest = "0"
        }
        return _multikillBest
    }
    
    var soloKillsMostInGame: String {
        if _soloKillsMostInGame == nil {
            _soloKillsMostInGame = "0"
        }
        return _soloKillsMostInGame
    }
    
    var timeSpentOnFireMostInGame: String {
        if _timeSpentOnFireMostInGame == nil {
            _timeSpentOnFireMostInGame = "0"
        }
        return _timeSpentOnFireMostInGame
    }

    //Average
    private var _meleeFinalBlowsAverage: String!
    private var _timeSpentOnFireAverage: String!
    private var _soloKillsAverage: String!
    private var _objectiveTimeAverage: String!
    private var _objectiveKillsAverage: String!
    private var _healingDoneAverage: String!
    private var _finalBlowsAverage: String!
    private var _deathsAverage: String!
    private var _damageDoneAverage: String!
    private var _eliminationsAverage: String!
    
    var meleeFinalBlowsAverage: String {
        if _meleeFinalBlowsAverage == nil {
            _meleeFinalBlowsAverage = "0"
        }
        return _meleeFinalBlowsAverage
    }
    
    var timeSpentOnFireAverage: String {
        if _timeSpentOnFireAverage == nil {
            _timeSpentOnFireAverage = "0"
        }
        return _timeSpentOnFireAverage
    }
    
    var soloKillsAverage: String {
        if _soloKillsAverage == nil {
            _soloKillsAverage = "0"
        }
        return _soloKillsAverage
    }
    
    var objectiveTimeAverage: String {
        if _objectiveTimeAverage == nil {
            _objectiveTimeAverage = "0"
        }
        return _objectiveTimeAverage
    }
    
    var objectiveKillsAverage: String {
        if _objectiveKillsAverage == nil {
            _objectiveKillsAverage = "0"
        }
        return _objectiveKillsAverage
    }
    
    var healingDoneAverage: String {
        if _healingDoneAverage == nil {
            _healingDoneAverage = "0"
        }
        return _healingDoneAverage
    }
    
    var finalBlowsAverage: String {
        if _finalBlowsAverage == nil {
            _finalBlowsAverage = "0"
        }
        return _finalBlowsAverage
    }
    
    var deathsAverage: String {
        if _deathsAverage == nil {
            _deathsAverage = "0"
        }
        return _deathsAverage
    }
    
    var damageDoneAverage: String {
        if _damageDoneAverage == nil {
            _damageDoneAverage = "0"
        }
        return _damageDoneAverage
    }
    
    var eliminationsAverage: String {
        if _eliminationsAverage == nil {
            _eliminationsAverage = "0"
        }
        return _eliminationsAverage
    }
    
    //Deaths
    private var _deaths: String!
    private var _environmentalDeaths: String!
    
    var deaths: String {
        if _deaths == nil {
            _deaths = "0"
        }
        return _deaths
    }
    
    var environmentalDeaths: String {
        if _environmentalDeaths == nil {
            _environmentalDeaths = "0"
        }
        return _environmentalDeaths
    }
    
    //Match Awards
    private var _cards: String!
    private var _medals: String!
    private var _medalsGold: String!
    private var _medalsSilver: String!
    private var _medalsBronze: String!
    
    var cards: String {
        if _cards == nil {
            _cards = "0"
        }
        return _cards
    }
    
    var medals: String {
        if _medals == nil {
            _medals = "0"
        }
        return _medals
    }
    
    var medalsGold: String {
        if _medalsGold == nil {
            _medalsGold = "0"
        }
        return _medalsGold
    }
    
    var medalsSilver: String {
        if _medalsSilver == nil {
            _medalsSilver = "0"
        }
        return _medalsSilver
    }
    
    var medalsBronze: String {
        if _medalsBronze == nil {
            _medalsBronze = "0"
        }
        return _medalsBronze
    }
    
    //Games
    private var _gamesWon: String!
    private var _timeSpentOnFire: String!
    private var _objectiveTime: String!
    private var _timePlayed: String!
    
    var gamesWon: String {
        if _gamesWon == nil {
            _gamesWon = "0"
        }
        return _gamesWon
    }
    
    var timeSpentOnFire: String {
        if _timeSpentOnFire == nil {
            _timeSpentOnFire = "0"
        }
        return _timeSpentOnFire
    }
    
    var objectiveTime: String {
        if _objectiveTime == nil {
            _objectiveTime = "0"
        }
        return _objectiveTime
    }
    
    var timePlayed: String {
        if _timePlayed == nil {
            _timePlayed = "0"
        }
        return _timePlayed
    }
    
    //Misc
    private var _meleeFinalBlowsMostInGame: String!
    private var _reconAssistsAverage: String!
    private var _defensiveAssists: String!
    private var _defensiveAssistsAverage: String!
    private var _offensiveAssists: String!
    private var _offensiveAssistsAverage: String!
    
    var meleeFinalBlowsMostInGame: String {
        if _meleeFinalBlowsMostInGame == nil {
            _meleeFinalBlowsMostInGame = "0"
        }
        return _meleeFinalBlowsMostInGame
    }
    
    var reconAssistsAverage: String {
        if _reconAssistsAverage == nil {
            _reconAssistsAverage = "0"
        }
        return _reconAssistsAverage
    }
    
    var defensiveAssists: String {
        if _defensiveAssists == nil {
            _defensiveAssists = "0"
        }
        return _defensiveAssists
    }
    
    var defensiveAssistsAverage: String {
        if _defensiveAssistsAverage == nil {
            _defensiveAssistsAverage = "0"
        }
        return _defensiveAssistsAverage
    }
    
    var offensiveAssists: String {
        if _offensiveAssists == nil {
            _offensiveAssists = "0"
        }
        return _offensiveAssists
    }
    
    var offensiveAssistsAverage: String {
        if _offensiveAssistsAverage == nil {
            _offensiveAssistsAverage = "0"
        }
        return _offensiveAssistsAverage
    }

    
    func downloadPlayerQPStats(completed: @escaping DownloadComplete) {
        let url = UserDefaults.standard.string(forKey: "playerStatsQP")
        
        Alamofire.request(url!).responseJSON { response in
            let download = response.result	
            
            if let JSON =  download.value as? Dictionary<String, AnyObject> {
                print("Downloading player data.")
                
                //Combat
                if let meleeFinalBlows = JSON["MeleeFinalBlows"] as? String {
                    self._meleeFinalBlows = meleeFinalBlows
                }
                if let soloKills = JSON["SoloKills"] as? String {
                    self._soloKills = soloKills
                }
                if let objectiveKills = JSON["ObjectiveKills"] as? String {
                    self._objectiveKills = objectiveKills
                }
                if let finalBlows = JSON["FinalBlows"] as? String {
                    self._finalBlows = finalBlows
                }
                if let damageDone = JSON["DamageDone"] as? String {
                    self._damageDone = damageDone
                }
                if let eliminations = JSON["Eliminations"] as? String {
                    self._eliminations = eliminations
                }
                if let environmentalKills = JSON["EnvironmentalKills"] as? String {
                    self._environmentalKills = environmentalKills
                }
                if let multikills = JSON["Multikills"] as? String {
                    self._multikills = multikills
                }
                
                //Assists
                if let reconAssists = JSON["ReconAssists"] as? String {
                    self._reconAssists = reconAssists
                }
                if let healingDone = JSON["HealingDone"] as? String {
                    self._healingDone = healingDone
                }
                if let teleporterPadsDestroyed = JSON["TeleporterPadsDestroyed"] as? String {
                    self._teleporterPadsDestroyed = teleporterPadsDestroyed
                }
                
                //Best
                if let eliminationsMostInGame = JSON["Eliminations-MostinGame"] as? String {
                    self._eliminationsMostInGame = eliminationsMostInGame
                }
                if let finalBlowsMostInGame = JSON["FinalBlows-MostinGame"] as? String {
                    self._finalBlowsMostInGame = finalBlowsMostInGame
                }
                if let damageDoneMostInGame = JSON["DamageDone-MostinGame"] as? String {
                    self._damageDoneMostInGame = damageDoneMostInGame
                }
                if let healingDoneMostInGame = JSON["HealingDone-MostinGame"] as? String {
                    self._healingDoneMostInGame = healingDoneMostInGame
                }
                if let defensiveAssistsMostInGame = JSON["DefensiveAssists-MostinGame"] as? String {
                    self._defensiveAssistsMostInGame = defensiveAssistsMostInGame
                }
                if let offensiveAssistsMostInGame = JSON["OffensiveAssists-MostinGame"] as? String {
                    self._offensiveAssistsMostInGame = offensiveAssistsMostInGame
                }
                if let objectiveKillsMostInGame = JSON["ObjectiveKills-MostinGame"] as? String {
                    self._objectiveKillsMostInGame = objectiveKillsMostInGame
                }
                if let objectiveTimeMostInGame = JSON["ObjectiveTime-MostinGame"] as? String {
                    self._objectiveTimeMostInGame = objectiveTimeMostInGame
                }
                if let multikillBest = JSON["Multikill-Best"] as? String {
                    self._multikillBest = multikillBest
                }
                if let soloKillsMostInGame = JSON["SoloKills-MostinGame"] as? String {
                    self._soloKillsMostInGame = soloKillsMostInGame
                }
                if let timeSpentOnFireMostInGame = JSON["TimeSpentonFire-MostinGame"] as? String {
                    self._timeSpentOnFireMostInGame = timeSpentOnFireMostInGame
                }
                
                //Average
                if let meleeFinalBlowsAverage = JSON["MeleeFinalBlows-Average"] as? String {
                    self._meleeFinalBlowsAverage = meleeFinalBlowsAverage
                }
                if let timeSpentOnFireAverage = JSON["TimeSpentonFire-Average"] as? String {
                    self._timeSpentOnFireAverage = timeSpentOnFireAverage
                }
                if let soloKillsAverage = JSON["SoloKills-Average"] as? String {
                    self._soloKillsAverage = soloKillsAverage
                }
                if let objectiveTimeAverage = JSON["ObjectiveTime-Average"] as? String {
                    self._objectiveTimeAverage = objectiveTimeAverage
                }
                if let objectiveKillsAverage = JSON["ObjectiveKills-Average"] as? String {
                    self._objectiveKillsAverage = objectiveKillsAverage
                }
                if let healingDoneAverage = JSON["HealingDone-Average"] as? String {
                    self._healingDoneAverage = healingDoneAverage
                }
                if let finalBlowsAverage = JSON["FinalBlows-Average"] as? String {
                    self._finalBlowsAverage = finalBlowsAverage
                }
                if let deathsAverage = JSON["Deaths-Average"] as? String {
                    self._deathsAverage = deathsAverage
                }
                if let damageDoneAverage = JSON["DamageDone-Average"] as? String {
                    self._damageDoneAverage = damageDoneAverage
                }
                if let eliminationsAverage = JSON["Eliminations-Average"] as? String {
                    self._eliminationsAverage = eliminationsAverage
                }
                
                //Deaths
                if let deaths = JSON["Deaths"] as? String {
                    self._deaths = deaths
                }
                if let environmentalDeaths = JSON["EnvironmentalDeaths"] as? String {
                    self._environmentalDeaths = environmentalDeaths
                }
                
                //Match Awards
                if let cards = JSON["Cards"] as? String {
                    self._cards = cards
                }
                if let medals = JSON["Medals"] as? String {
                    self._medals = medals
                }
                if let medalsGold = JSON["Medals-Gold"] as? String {
                    self._medalsGold = medalsGold
                }
                if let medalsSilver = JSON["Medals-Silver"] as? String {
                    self._medalsSilver = medalsSilver
                }
                if let medalsBronze = JSON["Medals-Bronze"] as? String {
                    self._medalsBronze = medalsBronze
                }
                
                //Games
                if let gamesWon = JSON["GamesWon"] as? String {
                    self._gamesWon = gamesWon
                }
                if let timeSpentOnFire = JSON["TimeSpentonFire"] as? String {
                    self._timeSpentOnFire = timeSpentOnFire
                }
                if let objectiveTime = JSON["ObjectiveTime"] as? String {
                    self._objectiveTime = objectiveTime
                }
                if let timePlayed = JSON["TimePlayed"] as? String {
                    self._timePlayed = timePlayed
                }
                
                //Misc
                if let meleeFinalBlowsMostInGame = JSON["MeleeFinalBlows-MostinGame"] as? String {
                    self._meleeFinalBlowsMostInGame = meleeFinalBlowsMostInGame
                }
                if let reconAssistsAverage = JSON["ReconAssists-Average"] as? String {
                    self._reconAssistsAverage = reconAssistsAverage
                }
                if let defensiveAssists = JSON["DefensiveAssists"] as? String {
                    self._defensiveAssists = defensiveAssists
                }
                if let defensiveAssistsAverage = JSON["DefensiveAssists-Average"] as? String {
                    self._defensiveAssistsAverage = defensiveAssistsAverage
                }
                if let offensiveAssists = JSON["OffensiveAssists"] as? String {
                    self._offensiveAssists = offensiveAssists
                }
                if let offensiveAssistsAverage = JSON["OffensiveAssists-Average"] as? String {
                    self._offensiveAssistsAverage = offensiveAssistsAverage
                }
                
            }
            completed()
        }
    }
}
