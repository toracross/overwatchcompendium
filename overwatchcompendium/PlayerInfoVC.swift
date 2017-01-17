//
//  PlayerInfoVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/13/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.

import UIKit
import NVActivityIndicatorView

class PlayerInfoVC: UIViewController {

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
    
    
    var statsModel: PlayerModel!
    var savedPlayerName = UserDefaults.standard.string(forKey: "playerName")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statsModel = PlayerModel()
        playerName.text = savedPlayerName!.replacingOccurrences(of: "-", with: "#")
        
        self.startAnimatingObjects()
        self.statsModel.downloadStatsData { DownloadComplete in
            
            //Delay updating the image, it may return nil.
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                if self.statsModel.overallStatsCP.count != 0 {
                    self.playerDataControl.isHidden = false
                    self.playerStatsControl.isHidden = false
                }
                self.updatePlayerUIQP()
                self.stopAnimatingObjects()
            }
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
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Update Player Data to Quickplay Stats
    func updatePlayerUIQP() {
        let heroesPlaytimeQP: [Dictionary<String, Double>] = [statsModel.playtimeQP]
        let sortedHeroesQP = heroesPlaytimeQP.flatMap({$0}).sorted { $0.0.1 > $0.1.1}

        //Player Data
        let playerRankImg = "\(statsModel.overallStatsQP["tier"]!)"
        let playerLevel = "\(statsModel.overallStatsQP["level"]!)"
        let playerRank = "\(statsModel.overallStatsQP["comprank"]!)"
        //Quickplay
        let playerWinsQP = "\(statsModel.overallStatsQP["wins"]!)"
        
        //Pixel Portrait
        self.playerHeroImg.image = UIImage(named: "pixel\(sortedHeroesQP[0].key)")
        
        //Player Avatar Image
        if let avatarUrl = URL(string: "\(statsModel.overallStatsQP["avatar"]!)") {
            do {
                let avatarData = try Data(contentsOf: avatarUrl)
                self.playerAvatarImg.image = UIImage(data: avatarData)
            } catch {
                print("Could not find image file.")
                print(avatarUrl)
            }
        }
        
        //Player Rank Image
        if playerRankImg != "<null>" {
            self.playerTierImg.image = UIImage(named: "\(playerRankImg)")
        } else {
            print("No Rank.")
            self.playerTierImg.image = UIImage(named: "false")
        }
        
        self.playerLevelCP.text = "\(playerLevel)"
        self.playerCompRank.text = "\(playerRank)"
        self.playerWinsQP.text = "\(playerWinsQP)"
        self.playerGames.text = "--"
        self.playerTiesCP.text = "--"
        self.playerLossesCP.text = "--"
        self.playerWinRateCP.text = "--"
        self.gameType.text = "Quickplay"
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
        //Combat
        self.meleeFinalBlows.text = "\(statsModel.gameStatsQP["melee_final_blows"]!)"
        self.soloKills.text = "\(statsModel.gameStatsQP["solo_kills"]!)"
        
        //Assists
        
        //Average
        self.meleeFinalBlowsAverage.text = "\(statsModel.averageStatsQP["final_blows_avg"]!)"
        self.timeSpentOnFireAverage.text = "\(statsModel.averageStatsQP["time_spent_on_fire_avg"]!)"
        self.soloKillsAverage.text = "\(statsModel.averageStatsQP["solo_kills_avg"]!)"
        self.objectiveTimeAverage.text = "\(statsModel.averageStatsQP["objective_kills_avg"]!)"
        self.objectiveKillsAverage.text = "\(statsModel.averageStatsQP["objective_kills_avg"]!)"
        self.healingDoneAverage.text = "\(statsModel.averageStatsQP["healing_done_avg"]!)"
        self.finalBlowsAverage.text = "\(statsModel.averageStatsQP["final_blows_avg"]!)"
        self.deathsAverage.text = "\(statsModel.averageStatsQP["deaths_avg"]!)"
        self.damageDoneAverage.text = "\(statsModel.averageStatsQP["damage_done_avg"]!)"
        self.eliminationsAverage.text = "\(statsModel.averageStatsQP["eliminations_avg"])"
        //Misc
        
        //Best
        
        //Match Awards
        
        //Game
        
        //Deaths
        self.deaths.text = "\(statsModel.gameStatsQP["deaths"])"
        
    }
    
    func updateStatsUICP() {
        //Combat
        
        //Assists
        
        //Average
        self.meleeFinalBlowsAverage.text = "\(statsModel.averageStatsCP["final_blows_avg"]!)"
        self.timeSpentOnFireAverage.text = "\(statsModel.averageStatsCP["time_spent_on_fire_avg"]!)"
        self.soloKillsAverage.text = "\(statsModel.averageStatsCP["solo_kills_avg"]!)"
        self.objectiveTimeAverage.text = "\(statsModel.averageStatsCP["objective_kills_avg"]!)"
        self.objectiveKillsAverage.text = "\(statsModel.averageStatsCP["objective_kills_avg"]!)"
        self.healingDoneAverage.text = "\(statsModel.averageStatsCP["healing_done_avg"]!)"
        self.finalBlowsAverage.text = "\(statsModel.averageStatsCP["final_blows_avg"]!)"
        self.deathsAverage.text = "\(statsModel.averageStatsCP["deaths_avg"]!)"
        self.damageDoneAverage.text = "\(statsModel.averageStatsCP["damage_done_avg"]!)"
        self.eliminationsAverage.text = "\(statsModel.averageStatsCP["eliminations_avg"]!)"
        
        //Misc
        
        //Best
        
        //Match Awards
        
        //Game
        
        //Deaths
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
