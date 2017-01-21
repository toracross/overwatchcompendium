//
//  PlayerInfoVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/13/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.

import UIKit
import NVActivityIndicatorView

class PlayerInfoVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var statsModel: PlayerModel!
    var savedPlayerName = UserDefaults.standard.string(forKey: "playerName")
    
    
    //Title
    @IBOutlet weak var playerName: CustomLblTitle!
    @IBOutlet weak var gameType: UILabel!
    //Player Data
    @IBOutlet weak var playerDataControl: UISegmentedControl!
    @IBOutlet weak var playerAvatarImg: UIImageView!
    @IBOutlet weak var playerAvatarLoad: NVActivityIndicatorView!
    @IBOutlet weak var playerHeroImg: UIImageView!
    @IBOutlet weak var playerHeroLoad: NVActivityIndicatorView!
    @IBOutlet weak var playerTierImg: UIImageView!
    @IBOutlet weak var playerTierLoad: NVActivityIndicatorView!
    //Quickplay
    @IBOutlet weak var playerWinsQP: UILabel!
    //Competitive
    @IBOutlet weak var playerTiesCP: UILabel!
    @IBOutlet weak var playerCompRank: UILabel!
    @IBOutlet weak var playerWinRateCP: UILabel!
    @IBOutlet weak var playerLossesCP: UILabel!
    @IBOutlet weak var playerGames: UILabel!
    @IBOutlet weak var playerLevelCP: UILabel!
    @IBOutlet weak var playerLevelFrame: UIImageView!
    //Stats
    @IBOutlet weak var playerStatsControl: UISegmentedControl!
    //Combat
    @IBOutlet weak var meleeFinalBlows: UILabel!
    @IBOutlet weak var soloKills: UILabel!
    @IBOutlet weak var objectiveKills: UILabel!
    @IBOutlet weak var finalBlows: UILabel!
    @IBOutlet weak var damageDone: UILabel!
    @IBOutlet weak var eliminations: UILabel!
    @IBOutlet weak var environmentalKills: UILabel!
    @IBOutlet weak var multiKills: UILabel!
    //Assists
    @IBOutlet weak var reconAssists: UILabel!
    @IBOutlet weak var healingDone: UILabel!
    @IBOutlet weak var teleporterPadsDestroyed: UILabel!
    //Average
    @IBOutlet weak var meleeFinalBlowsAverage: UILabel!
    @IBOutlet weak var timeSpentOnFireAverage: UILabel!
    @IBOutlet weak var soloKillsAverage: UILabel!
    @IBOutlet weak var objectiveTimeAverage: UILabel!
    @IBOutlet weak var objectiveKillsAverage: UILabel!
    @IBOutlet weak var healingDoneAverage: UILabel!
    @IBOutlet weak var finalBlowsAverage: UILabel!
    @IBOutlet weak var deathsAverage: UILabel!
    @IBOutlet weak var damageDoneAverage: UILabel!
    @IBOutlet weak var eliminationsAverage: UILabel!
    //Misc
    @IBOutlet weak var meleeFinalBlowsMostInGame: UILabel!
    @IBOutlet weak var reconAssistsAverage: UILabel!
    @IBOutlet weak var defensiveAssists: UILabel!
    @IBOutlet weak var defensiveAssistsAverage: UILabel!
    @IBOutlet weak var offensiveAssists: UILabel!
    @IBOutlet weak var offensiveAssistsAverage: UILabel!
    //Best
    @IBOutlet weak var eliminationsMost: UILabel!
    @IBOutlet weak var finalBlowsMost: UILabel!
    @IBOutlet weak var damageDoneMost: UILabel!
    @IBOutlet weak var healingDoneMost: UILabel!
    @IBOutlet weak var defensiveAssistsMost: UILabel!
    @IBOutlet weak var offensiveAssistsMost: UILabel!
    @IBOutlet weak var objectiveKillsMost: UILabel!
    @IBOutlet weak var objectiveTimeMost: UILabel!
    @IBOutlet weak var multiKillBest: UILabel!
    @IBOutlet weak var soloKillsMost: UILabel!
    @IBOutlet weak var timeSpentOnFireMost: UILabel!
    //Awards
    @IBOutlet weak var cards: UILabel!
    @IBOutlet weak var medals: UILabel!
    @IBOutlet weak var medalsGold: UILabel!
    @IBOutlet weak var medalsSilver: UILabel!
    @IBOutlet weak var medalsBronze: UILabel!
    //Game
    @IBOutlet weak var gamesWon: UILabel!
    @IBOutlet weak var timeSpentOnFire: UILabel!
    @IBOutlet weak var objectiveTime: UILabel!
    @IBOutlet weak var timePlayed: UILabel!
    //Deaths
    @IBOutlet weak var deaths: UILabel!
    @IBOutlet weak var environmentalDeaths: UILabel!
    
    //Heroes
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playerHeroControl: UISegmentedControl!
    
    //Achievements
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playerAchievementControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statsModel = PlayerModel()
        playerName.text = savedPlayerName!.replacingOccurrences(of: "-", with: "#")
        self.startAnimatingObjects()
        
        self.statsModel.downloadStatsData { DownloadComplete in
            if self.statsModel.overallStatsCP.count != 0 {
                self.playerDataControl.isHidden = false
                self.playerStatsControl.isHidden = false
                self.playerHeroControl.isHidden = false
            }
            self.updatePlayerUIQP()
            self.updateStatsUIQP()
            self.stopAnimatingObjects()

            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
        
    }
    
    @IBAction func playerDataSegmentPushed(_ sender: Any) {
        switch playerDataControl.selectedSegmentIndex {
        case 0:
            updatePlayerUIQP()
        case 1:
            updatePlayerUICP()
        default:
            break
        }
    }
    
    
    @IBAction func playerStatsSegmentPushed(_ sender: Any) {
        switch playerStatsControl.selectedSegmentIndex {
        case 0:
            updateStatsUIQP()
        case 1:
            updateStatsUICP()
        default:
            break
        }
    }
    
    @IBAction func playerHeroSegmentPushed(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    @IBAction func playerAchievementSegmentPushed(_ sender: Any) {
        self.collectionView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch playerHeroControl.selectedSegmentIndex {
        case 0: return statsModel.playtimeQP.count
        case 1: return statsModel.playtimeCP.count
        default:
            break
        }
        return playerHeroControl.selectedSegmentIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroTVCell", for: indexPath) as! HeroTVCell
        
        switch playerHeroControl.selectedSegmentIndex {
        case 0:
            let heroesPlaytimeQP: [Dictionary<String, Double>] = [statsModel.playtimeQP]
            let sortedHeroesQP = heroesPlaytimeQP.flatMap({$0}).sorted { $0.0.1 > $0.1.1}
            let heroesIndexPath = sortedHeroesQP[indexPath.item].value
            
            cell.heroName.text = "\(sortedHeroesQP[indexPath.item].key)"
            cell.heroImg.image = UIImage(named: "\(sortedHeroesQP[indexPath.item].key)")
            cell.heroPercentage.progressImage = UIImage(named: "\(sortedHeroesQP[indexPath.item].key)-progress")
            cell.heroPercentage.progress = Float(heroesIndexPath) / Float(sortedHeroesQP[0].value)
            cell.heroPlaytime.text = "\(Double(round(100 * heroesIndexPath) / 100)) HRS"
        case 1:
            let heroesPlaytimeCP: [Dictionary<String, Double>] = [statsModel.playtimeCP]
            let sortedHeroesCP = heroesPlaytimeCP.flatMap({$0}).sorted { $0.0.1 > $0.1.1}
            let heroesIndexPath = sortedHeroesCP[indexPath.item].value
            
            cell.heroName.text = "\(sortedHeroesCP[indexPath.item].key)"
            cell.heroImg.image = UIImage(named: "\(sortedHeroesCP[indexPath.item].key)")
            cell.heroPercentage.progressImage = UIImage(named: "\(sortedHeroesCP[indexPath.item].key)-progress")
            cell.heroPercentage.progress = Float(heroesIndexPath) / Float(sortedHeroesCP[0].value)
            cell.heroPlaytime.text = "\(Double(round(100 * heroesIndexPath) / 100)) HRS"
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch playerAchievementControl.selectedSegmentIndex {
        case 0: return statsModel.general.count
        case 1: return statsModel.maps.count
        case 2: return statsModel.offense.count
        case 3: return statsModel.defense.count
        case 4: return statsModel.tank.count
        case 5: return statsModel.support.count
        case 6: return statsModel.special.count
        default:
            break
        }
        
        return playerAchievementControl.selectedSegmentIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as! AchievementCell
        
        switch playerAchievementControl.selectedSegmentIndex {
        case 0:
            let achievements = Array(statsModel.general)
            let name = "\(achievements[indexPath.item].key)"
            let earned: Bool = achievements[indexPath.item].value as! Bool
            cell.achievementName.text = name.replacingOccurrences(of: "_", with: " ")
            cell.achievementImg.image = UIImage(named: "\(name)")
            if earned == true { cell.alpha = 1 } else { cell.alpha = 0.3 }
        case 1:
            let achievements = Array(statsModel.maps)
            let name = "\(achievements[indexPath.item].key)"
            let earned: Bool = achievements[indexPath.item].value as! Bool
            cell.achievementName.text = name.replacingOccurrences(of: "_", with: " ")
            cell.achievementImg.image = UIImage(named: "\(name)")
            if earned == true { cell.alpha = 1 } else { cell.alpha = 0.3 }
        case 2:
            let achievements = Array(statsModel.offense)
            let name = "\(achievements[indexPath.item].key)"
            let earned: Bool = achievements[indexPath.item].value as! Bool
            cell.achievementName.text = name.replacingOccurrences(of: "_", with: " ")
            cell.achievementImg.image = UIImage(named: "\(name)")
            if earned == true { cell.alpha = 1 } else { cell.alpha = 0.3 }
        case 3:
            let achievements = Array(statsModel.defense)
            let name = "\(achievements[indexPath.item].key)"
            let earned: Bool = achievements[indexPath.item].value as! Bool
            cell.achievementName.text = name.replacingOccurrences(of: "_", with: " ")
            cell.achievementImg.image = UIImage(named: "\(name)")
            if earned == true { cell.alpha = 1 } else { cell.alpha = 0.3 }
        case 4:
            let achievements = Array(statsModel.tank)
            let name = "\(achievements[indexPath.item].key)"
            let earned: Bool = achievements[indexPath.item].value as! Bool
            cell.achievementName.text = name.replacingOccurrences(of: "_", with: " ")
            cell.achievementImg.image = UIImage(named: "\(name)")
            if earned == true { cell.alpha = 1 } else { cell.alpha = 0.3 }
        case 5:
            let achievements = Array(statsModel.support)
            let name = "\(achievements[indexPath.item].key)"
            let earned: Bool = achievements[indexPath.item].value as! Bool
            cell.achievementName.text = name.replacingOccurrences(of: "_", with: " ")
            cell.achievementImg.image = UIImage(named: "\(name)")
            if earned == true { cell.alpha = 1 } else { cell.alpha = 0.3 }
        case 6:
            let achievements = Array(statsModel.special)
            let name = "\(achievements[indexPath.item].key)"
            let earned: Bool = achievements[indexPath.item].value as! Bool
            cell.achievementName.text = name.replacingOccurrences(of: "_", with: " ")
            cell.achievementImg.image = UIImage(named: "\(name)")
            if earned == true { cell.alpha = 1 } else { cell.alpha = 0.3 }
        default:
            break
        }
        
        return cell
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Update Player Data to Quickplay Stats
    func updatePlayerUIQP() {
        let heroesPlaytimeQP: [Dictionary<String, Double>] = [statsModel.playtimeQP]
        let sortedHeroesQP = heroesPlaytimeQP.flatMap({$0}).sorted { $0.0.1 > $0.1.1}
        
        let prestige = self.statsModel.overallStatsQP["prestige"]! as! Int
        let level = self.statsModel.overallStatsQP["level"]!
        let playerRankImg = "\(statsModel.overallStatsQP["tier"]!)"
        let playerLevel = "\(statsModel.overallStatsQP["level"]!)"
        let playerRank = "\(statsModel.overallStatsQP["comprank"]!)"
        let playerWinsQP = "\(statsModel.overallStatsQP["wins"]!)"
        
        self.playerLevelCP.text = "\(playerLevel)"
        self.playerCompRank.text = "\(playerRank)"
        self.playerWinsQP.text = "\(playerWinsQP)"
        self.playerGames.text = "--"
        self.playerTiesCP.text = "--"
        self.playerLossesCP.text = "--"
        self.playerWinRateCP.text = "--"
        self.gameType.text = "Quickplay"
        self.playerHeroImg.image = UIImage(named: "pixel\(sortedHeroesQP[0].key)")
        
        if let avatarUrl = URL(string: "\(statsModel.overallStatsQP["avatar"]!)") {
            do {
                let avatarData = try Data(contentsOf: avatarUrl)
                self.playerAvatarImg.image = UIImage(data: avatarData)
            } catch {
                print("Could not find image file.")
                print(avatarUrl)
            }
        }
        
        if playerRankImg != "<null>" {
            self.playerTierImg.image = UIImage(named: "\(playerRankImg)")
        } else {
            self.playerTierImg.image = UIImage(named: "false")
        }
        
        if prestige != 0 {
            self.playerLevelFrame.image = UIImage(named: "\(prestige)\(level)")
        } else if prestige == 0 {
            self.playerLevelFrame.image = UIImage(named: "\(level)")
        }
    }
    
    //Update Player Data to Competitive Data
    func updatePlayerUICP() {
        let heroesPlaytimeCP: [Dictionary<String, Double>] = [statsModel.playtimeCP]
        let sortedHeroesCP = heroesPlaytimeCP.flatMap({$0}).sorted { $0.0.1 > $0.1.1}
        
        let playerWinsCP = "\(statsModel.overallStatsCP["wins"]!)"
        let playerGamesCP = "\(statsModel.overallStatsCP["games"]!)"
        let playerTiesCP = "\(statsModel.overallStatsCP["ties"]!)"
        let playerLossesCP = "\(statsModel.overallStatsCP["losses"]!)"
        let playerWinRateCP = "\(statsModel.overallStatsCP["win_rate"]!)"
        
        self.playerHeroImg.image = UIImage(named: "pixel\(sortedHeroesCP[0].key)")
        
        self.playerWinsQP.text = "\(playerWinsCP)"
        self.playerGames.text = "\(playerGamesCP)"
        self.playerTiesCP.text = "\(playerTiesCP)"
        self.playerLossesCP.text = "\(playerLossesCP)"
        self.playerWinRateCP.text = "\(playerWinRateCP) %"
        self.gameType.text = "Competitive"
    }
    
    func updateStatsUIQP() {
        //There's always the possibility of code returning nil due to getters, if else takes care of that.
        //Combat
        if statsModel.gameStatsQP["melee_final_blows"] != nil { self.meleeFinalBlows.text = "\(statsModel.gameStatsQP["melee_final_blows"]!)" }
        if statsModel.gameStatsQP["solo_kills"] != nil { self.soloKills.text = "\(statsModel.gameStatsQP["solo_kills"]!)" }
        if statsModel.gameStatsQP["objective_kills"] != nil { self.objectiveKills.text = "\(statsModel.gameStatsQP["objective_kills"]!)" }
        if statsModel.gameStatsQP["final_blows"] != nil { self.finalBlows.text = "\(statsModel.gameStatsQP["final_blows"]!)" }
        if statsModel.gameStatsQP["damage_done"] != nil { self.damageDone.text = "\(statsModel.gameStatsQP["damage_done"]!)" }
        if statsModel.gameStatsQP["eliminations"] != nil { self.eliminations.text = "\(statsModel.gameStatsQP["eliminations"]!)" }
        if statsModel.gameStatsQP["environmental_kills"] != nil { self.environmentalKills.text = "\(statsModel.gameStatsQP["environmental_kills"]!)" }
        if statsModel.gameStatsQP["multikills"] != nil { self.multiKills.text = "\(statsModel.gameStatsQP["multikills"]!)" }
        //Assists
        if statsModel.gameStatsQP["recon_assists"] != nil { self.reconAssists.text = "\(statsModel.gameStatsQP["recon_assists"]!)" }
        if statsModel.gameStatsQP["healing_done"] != nil { self.healingDone.text = "\(statsModel.gameStatsQP["healing_done"]!)" }
        if statsModel.gameStatsQP["teleporter_pads_destroyed"] != nil { self.teleporterPadsDestroyed.text = "\(statsModel.gameStatsQP["teleporter_pads_destroyed"]!)" }
        //Average
        if statsModel.averageStatsQP["final_blows_avg"] != nil {
            let meleeFinalBlowsAverage = "\(statsModel.averageStatsQP["final_blows_avg"]!)"
            self.meleeFinalBlowsAverage.text = "\(String(meleeFinalBlowsAverage.characters.prefix(4)))"
            
        }
        if statsModel.averageStatsQP["time_spent_on_fire_avg"] != nil {
            let timeSpentOnFireAverage = "\(statsModel.averageStatsQP["time_spent_on_fire_avg"]!)"
            self.timeSpentOnFireAverage.text = "\(String(timeSpentOnFireAverage.characters.prefix(4))) HRS"
            
        }
        if statsModel.averageStatsQP["solo_kills_avg"] != nil {
            let soloKillsAverage = "\(statsModel.averageStatsQP["solo_kills_avg"]!)"
            self.soloKillsAverage.text = "\(String(soloKillsAverage.characters.prefix(4)))"
            
        }
        if statsModel.averageStatsQP["objective_time_avg"] != nil {
            let objectiveTimeAverage = "\(statsModel.averageStatsQP["objective_time_avg"]!)"
            self.objectiveTimeAverage.text = "\(String(objectiveTimeAverage.characters.prefix(4))) HRS"
            
        }
        if statsModel.averageStatsQP["objective_kills_avg"] != nil {
            let objectiveKillsAverage = "\(statsModel.averageStatsQP["objective_kills_avg"]!)"
            self.objectiveKillsAverage.text = "\(String(objectiveKillsAverage.characters.prefix(4)))"
            
        }
        if statsModel.averageStatsQP["healing_done_avg"] != nil {
            let healingDoneAverage = "\(statsModel.averageStatsQP["healing_done_avg"]!)"
            self.healingDoneAverage.text = "\(String(healingDoneAverage.characters.prefix(4)))"
            
        }
        if statsModel.averageStatsQP["final_blows_avg"] != nil {
            let finalBlowsAverage = "\(statsModel.averageStatsQP["final_blows_avg"]!)"
            self.finalBlowsAverage.text = "\(String(finalBlowsAverage.characters.prefix(4)))"
            
        }
        if statsModel.averageStatsQP["deaths_avg"] != nil {
            let deathsAverage =  "\(statsModel.averageStatsQP["deaths_avg"]!)"
            self.deathsAverage.text = "\(String(deathsAverage.characters.prefix(4)))"
            
        }
        if statsModel.averageStatsQP["damage_done_avg"] != nil {
            let damageDoneAverage = "\(statsModel.averageStatsQP["damage_done_avg"]!)"
            self.damageDoneAverage.text = "\(String(damageDoneAverage.characters.prefix(4)))"
            
        }
        if statsModel.averageStatsQP["eliminations_avg"] != nil {
            let eliminationsAverage = "\(statsModel.averageStatsQP["eliminations_avg"]!)"
            self.eliminationsAverage.text = "\(String(eliminationsAverage.characters.prefix(4)))"
            
        }
        //Misc
        if statsModel.gameStatsQP["melee_final_blows_most_in_game"] != nil { self.meleeFinalBlowsMostInGame.text = "\(statsModel.gameStatsQP["melee_final_blows_most_in_game"]!)" }
        if statsModel.averageStatsQP["recon_assists_avg"] != nil { self.reconAssistsAverage.text = "\(statsModel.averageStatsQP["recon_assists_avg"]!)" }
        if statsModel.gameStatsQP["defensive_assists"] != nil { self.defensiveAssists.text = "\(statsModel.gameStatsQP["defensive_assists"]!)" }
        if statsModel.averageStatsQP["defensive_assists_avg"] != nil { self.defensiveAssistsAverage.text = "\(statsModel.averageStatsQP["defensive_assists_avg"]!)" }
        if statsModel.gameStatsQP["offensive_assists"] != nil { self.offensiveAssists.text = "\(statsModel.gameStatsQP["offensive_assists"]!)" }
        if statsModel.averageStatsQP["offensive_assists_avg"] != nil { self.offensiveAssistsAverage.text = "\(statsModel.averageStatsQP["offensive_assists_avg"]!)" }
        //Best
        if statsModel.gameStatsQP["eliminations_most_in_game"] != nil { self.eliminationsMost.text = "\(statsModel.gameStatsQP["eliminations_most_in_game"]!)" }
        if statsModel.gameStatsQP["final_blows_most_in_game"] != nil { self.finalBlowsMost.text = "\(statsModel.gameStatsQP["final_blows_most_in_game"]!)" }
        if statsModel.gameStatsQP["damage_done_most_in_game"] != nil { self.damageDoneMost.text = "\(statsModel.gameStatsQP["damage_done_most_in_game"]!)" }
        if statsModel.gameStatsQP["healing_done_most_in_game"] != nil { self.healingDoneMost.text = "\(statsModel.gameStatsQP["healing_done_most_in_game"]!)" }
        if statsModel.gameStatsQP["defensive_assists_most_in_game"] != nil { self.defensiveAssistsMost.text = "\(statsModel.gameStatsQP["defensive_assists_most_in_game"]!)" }
        if statsModel.gameStatsQP["offensive_assists_most_in_game"] != nil { self.offensiveAssistsMost.text = "\(statsModel.gameStatsQP["offensive_assists_most_in_game"]!)" }
        if statsModel.gameStatsQP["objective_kills_most_in_game"] != nil { self.objectiveKillsMost.text = "\(statsModel.gameStatsQP["objective_kills_most_in_game"]!)" }
        if statsModel.gameStatsQP["objective_time_most_in_game"] != nil { self.objectiveTimeMost.text = "\(statsModel.gameStatsQP["objective_time_most_in_game"]!) HRS" }
        if statsModel.gameStatsQP["multikill_best"] != nil { self.multiKillBest.text = "\(statsModel.gameStatsQP["multikill_best"]!)" }
        if statsModel.gameStatsQP["solo_kills_most_in_game"] != nil { self.soloKillsMost.text = "\(statsModel.gameStatsQP["solo_kills_most_in_game"]!)" }
        if statsModel.gameStatsQP["time_spent_on_fire_most_in_game"] != nil {
            let timeSpentOnFireMost = "\(statsModel.gameStatsQP["time_spent_on_fire_most_in_game"]!)"
            self.timeSpentOnFireMost.text = "\(String(timeSpentOnFireMost.characters.prefix(4))) HRS"
        }
        //Match Awards
        if statsModel.gameStatsQP["cards"] != nil { self.cards.text = "\(statsModel.gameStatsQP["cards"]!)" }
        if statsModel.gameStatsQP["medals"] != nil { self.medals.text = "\(statsModel.gameStatsQP["medals"]!)" }
        if statsModel.gameStatsQP["medals_gold"] != nil { self.medalsGold.text = "\(statsModel.gameStatsQP["medals_gold"]!)" }
        if statsModel.gameStatsQP["medals_silver"] != nil { self.medalsSilver.text = "\(statsModel.gameStatsQP["medals_silver"]!)" }
        if statsModel.gameStatsQP["medals_bronze"] != nil { self.medalsBronze.text = "\(statsModel.gameStatsQP["medals_bronze"]!)" }
        //Game
        if statsModel.gameStatsQP["games_won"] != nil { self.gamesWon.text = "\(statsModel.gameStatsQP["games_won"]!)" }
        if statsModel.gameStatsQP["time_spent_on_fire"] != nil {
            let timeSpentOnFire = "\(statsModel.gameStatsQP["time_spent_on_fire"]!)"
            self.timeSpentOnFire.text = "\(String(timeSpentOnFire.characters.prefix(4))) HRS"
        }
        if statsModel.gameStatsQP["objective_time"] != nil {
            let objectiveTime = "\(statsModel.gameStatsQP["objective_time"]!)"
            self.objectiveTime.text = "\(String(objectiveTime.characters.prefix(4))) HRS"
        }
        if statsModel.gameStatsQP["time_played"] != nil { self.timePlayed.text = "\(statsModel.gameStatsQP["time_played"]!) HRS" }
        //Deaths
        if statsModel.gameStatsQP["deaths"] != nil { self.deaths.text = "\(statsModel.gameStatsQP["deaths"]!)" }
        if statsModel.gameStatsQP["environmental_deaths"] != nil { self.environmentalDeaths.text = "\(statsModel.gameStatsQP["environmental_deaths"]!)" }
    }
    
    func updateStatsUICP() {
        //There's always the possibility of code returning nil due to getters, if else takes care of that.
        //Combat
        if statsModel.gameStatsCP["melee_final_blows"] != nil { self.meleeFinalBlows.text = "\(statsModel.gameStatsCP["melee_final_blows"]!)" }
        if statsModel.gameStatsCP["solo_kills"] != nil { self.soloKills.text = "\(statsModel.gameStatsCP["solo_kills"]!)" }
        if statsModel.gameStatsCP["objective_kills"] != nil { self.objectiveKills.text = "\(statsModel.gameStatsCP["objective_kills"]!)" }
        if statsModel.gameStatsCP["final_blows"] != nil { self.finalBlows.text = "\(statsModel.gameStatsCP["final_blows"]!)" }
        if statsModel.gameStatsCP["damage_done"] != nil { self.damageDone.text = "\(statsModel.gameStatsCP["damage_done"]!)" }
        if statsModel.gameStatsCP["eliminations"] != nil { self.eliminations.text = "\(statsModel.gameStatsCP["eliminations"]!)" }
        if statsModel.gameStatsCP["environmental_kills"] != nil { self.environmentalKills.text = "\(statsModel.gameStatsCP["environmental_kills"]!)" }
        if statsModel.gameStatsCP["multikills"] != nil { self.multiKills.text = "\(statsModel.gameStatsCP["multikills"]!)" }
        //Assists
        if statsModel.gameStatsCP["recon_assists"] != nil { self.reconAssists.text = "\(statsModel.gameStatsCP["recon_assists"]!)" }
        if statsModel.gameStatsCP["healing_done"] != nil { self.healingDone.text = "\(statsModel.gameStatsCP["healing_done"]!)" }
        if statsModel.gameStatsCP["teleporter_pads_destroyed"] != nil { self.teleporterPadsDestroyed.text = "\(statsModel.gameStatsCP["teleporter_pads_destroyed"]!)" }
        //Average
        if statsModel.averageStatsCP["final_blows_avg"] != nil {
            let meleeFinalBlowsAverage = "\(statsModel.averageStatsCP["final_blows_avg"]!)"
            self.meleeFinalBlowsAverage.text = "\(String(meleeFinalBlowsAverage.characters.prefix(4)))"
        
        }
        if statsModel.averageStatsCP["time_spent_on_fire_avg"] != nil {
            let timeSpentOnFireAverage = "\(statsModel.averageStatsCP["time_spent_on_fire_avg"]!)"
            self.timeSpentOnFireAverage.text = "\(String(timeSpentOnFireAverage.characters.prefix(4))) HRS"
        
        }
        if statsModel.averageStatsCP["solo_kills_avg"] != nil {
            let soloKillsAverage = "\(statsModel.averageStatsCP["solo_kills_avg"]!)"
            self.soloKillsAverage.text = "\(String(soloKillsAverage.characters.prefix(4)))"
        
        }
        if statsModel.averageStatsCP["objective_time_avg"] != nil {
            let objectiveTimeAverage = "\(statsModel.averageStatsCP["objective_time_avg"]!)"
            self.objectiveTimeAverage.text = "\(String(objectiveTimeAverage.characters.prefix(4))) HRS"
        
        }
        if statsModel.averageStatsCP["objective_kills_avg"] != nil {
            let objectiveKillsAverage = "\(statsModel.averageStatsCP["objective_kills_avg"]!)"
            self.objectiveKillsAverage.text = "\(String(objectiveKillsAverage.characters.prefix(4)))"
        
        }
        if statsModel.averageStatsCP["healing_done_avg"] != nil {
            let healingDoneAverage = "\(statsModel.averageStatsCP["healing_done_avg"]!)"
            self.healingDoneAverage.text = "\(String(healingDoneAverage.characters.prefix(4)))"
        
        }
        if statsModel.averageStatsCP["final_blows_avg"] != nil {
            let finalBlowsAverage = "\(statsModel.averageStatsCP["final_blows_avg"]!)"
            self.finalBlowsAverage.text = "\(String(finalBlowsAverage.characters.prefix(4)))"
        
        }
        if statsModel.averageStatsCP["deaths_avg"] != nil {
            let deathsAverage =  "\(statsModel.averageStatsCP["deaths_avg"]!)"
            self.deathsAverage.text = "\(String(deathsAverage.characters.prefix(4)))"
        
        }
        if statsModel.averageStatsCP["damage_done_avg"] != nil {
            let damageDoneAverage = "\(statsModel.averageStatsCP["damage_done_avg"]!)"
            self.damageDoneAverage.text = "\(String(damageDoneAverage.characters.prefix(4)))"
        
        }
        if statsModel.averageStatsCP["eliminations_avg"] != nil {
            let eliminationsAverage = "\(statsModel.averageStatsCP["eliminations_avg"]!)"
            self.eliminationsAverage.text = "\(String(eliminationsAverage.characters.prefix(4)))"
        
        }
        //Misc
        if statsModel.gameStatsCP["melee_final_blows_most_in_game"] != nil { self.meleeFinalBlowsMostInGame.text = "\(statsModel.gameStatsCP["melee_final_blows_most_in_game"]!)" }
        if statsModel.averageStatsCP["recon_assists_avg"] != nil { self.reconAssistsAverage.text = "\(statsModel.averageStatsCP["recon_assists_avg"]!)" }
        if statsModel.gameStatsCP["defensive_assists"] != nil { self.defensiveAssists.text = "\(statsModel.gameStatsCP["defensive_assists"]!)" }
        if statsModel.averageStatsCP["defensive_assists_avg"] != nil { self.defensiveAssistsAverage.text = "\(statsModel.averageStatsCP["defensive_assists_avg"]!)" }
        if statsModel.gameStatsCP["offensive_assists"] != nil { self.offensiveAssists.text = "\(statsModel.gameStatsCP["offensive_assists"]!)" }
        if statsModel.averageStatsCP["offensive_assists_avg"] != nil { self.offensiveAssistsAverage.text = "\(statsModel.averageStatsCP["offensive_assists_avg"]!)" }
        //Best
        if statsModel.gameStatsCP["eliminations_most_in_game"] != nil { self.eliminationsMost.text = "\(statsModel.gameStatsCP["eliminations_most_in_game"]!)" }
        if statsModel.gameStatsCP["final_blows_most_in_game"] != nil { self.finalBlowsMost.text = "\(statsModel.gameStatsCP["final_blows_most_in_game"]!)" }
        if statsModel.gameStatsCP["damage_done_most_in_game"] != nil { self.damageDoneMost.text = "\(statsModel.gameStatsCP["damage_done_most_in_game"]!)" }
        if statsModel.gameStatsCP["healing_done_most_in_game"] != nil { self.healingDoneMost.text = "\(statsModel.gameStatsCP["healing_done_most_in_game"]!)" }
        if statsModel.gameStatsCP["defensive_assists_most_in_game"] != nil { self.defensiveAssistsMost.text = "\(statsModel.gameStatsCP["defensive_assists_most_in_game"]!)" }
        if statsModel.gameStatsCP["offensive_assists_most_in_game"] != nil { self.offensiveAssistsMost.text = "\(statsModel.gameStatsCP["offensive_assists_most_in_game"]!)" }
        if statsModel.gameStatsCP["objective_kills_most_in_game"] != nil { self.objectiveKillsMost.text = "\(statsModel.gameStatsCP["objective_kills_most_in_game"]!)" }
        if statsModel.gameStatsCP["objective_time_most_in_game"] != nil {
            let objectiveTimeMost = "\(statsModel.gameStatsCP["objective_time_most_in_game"]!)"
            self.objectiveTimeMost.text = "\(String(objectiveTimeMost.characters.prefix(4))) HRS"
        
        }
        if statsModel.gameStatsCP["multikill_best"] != nil { self.multiKillBest.text = "\(statsModel.gameStatsCP["multikill_best"]!)" }
        if statsModel.gameStatsCP["solo_kills_most_in_game"] != nil { self.soloKillsMost.text = "\(statsModel.gameStatsCP["solo_kills_most_in_game"]!)" }
        if statsModel.gameStatsCP["time_spent_on_fire_most_in_game"] != nil {
            let timeSpentOnFireMost = "\(statsModel.gameStatsCP["time_spent_on_fire_most_in_game"]!)"
            self.timeSpentOnFireMost.text = "\(String(timeSpentOnFireMost.characters.prefix(4))) HRS"
        }
        //Match Awards
        if statsModel.gameStatsCP["cards"] != nil { self.cards.text = "\(statsModel.gameStatsCP["cards"]!)" }
        if statsModel.gameStatsCP["medals"] != nil { self.medals.text = "\(statsModel.gameStatsCP["medals"]!)" }
        if statsModel.gameStatsCP["medals_gold"] != nil { self.medalsGold.text = "\(statsModel.gameStatsCP["medals_gold"]!)" }
        if statsModel.gameStatsCP["medals_silver"] != nil { self.medalsSilver.text = "\(statsModel.gameStatsCP["medals_silver"]!)" }
        if statsModel.gameStatsCP["medals_bronze"] != nil { self.medalsBronze.text = "\(statsModel.gameStatsCP["medals_bronze"]!)" }
        //Game
        if statsModel.gameStatsCP["games_won"] != nil { self.gamesWon.text = "\(statsModel.gameStatsCP["games_won"]!)" }
        if statsModel.gameStatsCP["time_spent_on_fire"] != nil {
            let timeSpentOnFire = "\(statsModel.gameStatsCP["time_spent_on_fire"]!)"
            self.timeSpentOnFire.text = "\(String(timeSpentOnFire.characters.prefix(4))) HRS"
        }
        if statsModel.gameStatsCP["objective_time"] != nil {
            let objectiveTime = "\(statsModel.gameStatsCP["objective_time"]!)"
            self.objectiveTime.text = "\(String(objectiveTime.characters.prefix(4))) HRS"
        }
        if statsModel.gameStatsCP["time_played"] != nil { self.timePlayed.text = "\(statsModel.gameStatsCP["time_played"]!) HRS" }
        //Deaths
        if statsModel.gameStatsCP["deaths"] != nil { self.deaths.text = "\(statsModel.gameStatsCP["deaths"]!)" }
        if statsModel.gameStatsCP["environmental_deaths"] != nil { self.environmentalDeaths.text = "\(statsModel.gameStatsCP["environmental_deaths"]!)" }
    }
    
    
    
    func startAnimatingObjects() {
        self.playerAvatarLoad.startAnimating()
        self.playerHeroLoad.startAnimating()
        self.playerTierLoad.startAnimating()

    }
    
    func stopAnimatingObjects() {
        self.playerAvatarLoad.stopAnimating()
        self.playerHeroLoad.stopAnimating()
        self.playerTierLoad.stopAnimating()

    }
    
    func alertFailMessage() {
        let alert = UIAlertController(title: "No data found.",
                                      message: "No Overwatch data was found with your battle tag, returning to previous menu.",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "CLOSE", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

