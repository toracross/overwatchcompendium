//
//  StatsVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/11/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class StatsVC: UIViewController, NVActivityIndicatorViewable {
    
    //Variables
    weak var timer: Timer?
    var playerStatsQP: PlayerStatsQP!
    var playerStatsCP: PlayerStatsCP!
    
    
    //Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var gameModeControl: UISegmentedControl!
    
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
    
    //Best
    @IBOutlet weak var eliminationsMostInGame: UILabel!
    @IBOutlet weak var finalBlowsMostInGame: UILabel!
    @IBOutlet weak var damageDoneMostInGame: UILabel!
    @IBOutlet weak var healingDoneMostInGame: UILabel!
    @IBOutlet weak var defensiveAssistsMostInGame: UILabel!
    @IBOutlet weak var offensiveAssistsMostInGame: UILabel!
    @IBOutlet weak var objectiveKillsMostInGame: UILabel!
    @IBOutlet weak var objectiveTimeMostInGame: UILabel!
    @IBOutlet weak var multikillBest: UILabel!
    @IBOutlet weak var soloKillsMostInGame: UILabel!
    @IBOutlet weak var timeSpentOnFireMostInGame: UILabel!
    
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
    
    //Deaths
    @IBOutlet weak var deaths: UILabel!
    @IBOutlet weak var environmentalDeaths: UILabel!
    
    //Match Awards
    @IBOutlet weak var cards: UILabel!
    @IBOutlet weak var medals: UILabel!
    @IBOutlet weak var medalsGold: UILabel!
    @IBOutlet weak var medalsSilver: UILabel!
    @IBOutlet weak var medalsBronze: UILabel!
    
    //Games
    @IBOutlet weak var gamesWon: UILabel!
    @IBOutlet weak var timeSpentOnFire: UILabel!
    @IBOutlet weak var objectiveTime: UILabel!
    @IBOutlet weak var timePlayed: UILabel!
    
    //Misc
    @IBOutlet weak var meleeFinalBlowsMostInGame: UILabel!
    @IBOutlet weak var reconAssistsAverage: UILabel!
    @IBOutlet weak var defensiveAssists: UILabel!
    @IBOutlet weak var defensiveAssistsAverage: UILabel!
    @IBOutlet weak var offensiveAssists: UILabel!
    @IBOutlet weak var offensiveAssistsAverage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerStatsQP = PlayerStatsQP()
        playerStatsCP = PlayerStatsCP()
        
        self.startAnimating(message:"Loading...")
        playerStatsQP.downloadPlayerQPStats {
            print("Quickplay Stats downloaded.")
            self.updateQPUI()
            self.playerStatsCP.downloadPlayerCPStats {
                self.stopAnimating()
                print("Competitive Stats downloaded.")
            }
        }
        repeatBackground()
    }

    @IBAction func statsUpdated(_ sender: Any) {
        switch gameModeControl.selectedSegmentIndex {
        case 0: updateQPUI()
        case 1: updateCPUI()
        default:
            break
        }
    }
    
    
    //Update UI
    func updateQPUI() {
        DispatchQueue.main.async {
            //Combat
            self.meleeFinalBlows.text = self.playerStatsQP.meleeFinalBlows
            self.soloKills.text = self.playerStatsQP.soloKills
            self.objectiveKills.text = self.playerStatsQP.objectiveKills
            self.finalBlows.text = self.playerStatsQP.finalBlows
            self.damageDone.text = self.playerStatsQP.damageDone
            self.eliminations.text = self.playerStatsQP.eliminations
            self.environmentalKills.text = self.playerStatsQP.environmentalKills
            self.multiKills.text = self.playerStatsQP.multikills
            //Assists
            self.reconAssists.text = self.playerStatsQP.reconAssists
            self.healingDone.text = self.playerStatsQP.healingDone
            self.teleporterPadsDestroyed.text = self.playerStatsQP.teleporterPadsDestroyed
            //Best
            self.eliminationsMostInGame.text = self.playerStatsQP.eliminationsMostInGame
            self.finalBlowsMostInGame.text = self.playerStatsQP.finalBlowsMostInGame
            self.damageDoneMostInGame.text = self.playerStatsQP.damageDoneMostInGame
            self.healingDoneMostInGame.text = self.playerStatsQP.healingDoneMostInGame
            self.defensiveAssistsMostInGame.text = self.playerStatsQP.defensiveAssistsMostInGame
            self.offensiveAssistsMostInGame.text = self.playerStatsQP.offensiveAssistsMostInGame
            self.objectiveKillsMostInGame.text = self.playerStatsQP.objectiveKillsMostInGame
            self.objectiveTimeMostInGame.text = self.playerStatsQP.objectiveTimeMostInGame
            self.multikillBest.text = self.playerStatsQP.multikillBest
            self.soloKillsMostInGame.text = self.playerStatsQP.soloKillsMostInGame
            self.timeSpentOnFireMostInGame.text = self.playerStatsQP.timeSpentOnFireMostInGame
            //Average
            self.meleeFinalBlowsAverage.text = self.playerStatsQP.meleeFinalBlowsAverage
            self.timeSpentOnFireAverage.text = self.playerStatsQP.timeSpentOnFireAverage
            self.soloKillsAverage.text = self.playerStatsQP.soloKillsAverage
            self.objectiveTimeAverage.text = self.playerStatsQP.objectiveTimeAverage
            self.objectiveKillsAverage.text = self.playerStatsQP.objectiveKillsAverage
            self.healingDoneAverage.text = self.playerStatsQP.healingDoneAverage
            self.finalBlowsAverage.text = self.playerStatsQP.finalBlowsAverage
            self.deathsAverage.text = self.playerStatsQP.deathsAverage
            self.damageDoneAverage.text = self.playerStatsQP.damageDoneAverage
            self.eliminationsAverage.text = self.playerStatsQP.eliminationsAverage
            //Deaths
            self.deaths.text = self.playerStatsQP.deaths
            self.environmentalDeaths.text = self.playerStatsQP.environmentalDeaths
            //Match Awards
            self.cards.text = self.playerStatsQP.cards
            self.medals.text = self.playerStatsQP.medals
            self.medalsGold.text = self.playerStatsQP.medalsGold
            self.medalsSilver.text = self.playerStatsQP.medalsSilver
            self.medalsBronze.text = self.playerStatsQP.medalsBronze
            //Games
            self.gamesWon.text = self.playerStatsQP.gamesWon
            self.timeSpentOnFire.text = self.playerStatsQP.timeSpentOnFire
            self.objectiveTime.text = self.playerStatsQP.objectiveTime
            self.timePlayed.text = self.playerStatsQP.timePlayed
            //Misc
            self.meleeFinalBlowsMostInGame.text = self.playerStatsQP.finalBlowsMostInGame
            self.reconAssistsAverage.text = self.playerStatsQP.reconAssistsAverage
            self.defensiveAssists.text = self.playerStatsQP.defensiveAssists
            self.defensiveAssistsAverage.text = self.playerStatsQP.defensiveAssistsAverage
            self.offensiveAssists.text = self.playerStatsQP.offensiveAssists
            self.offensiveAssistsAverage.text = self.playerStatsQP.offensiveAssistsAverage
        }

    }
    
    func updateCPUI() {
        DispatchQueue.main.async {
            //Combat
            self.meleeFinalBlows.text = self.playerStatsCP.meleeFinalBlows
            self.soloKills.text = self.playerStatsCP.soloKills
            self.objectiveKills.text = self.playerStatsCP.objectiveKills
            self.finalBlows.text = self.playerStatsCP.finalBlows
            self.damageDone.text = self.playerStatsCP.damageDone
            self.eliminations.text = self.playerStatsCP.eliminations
            self.environmentalKills.text = self.playerStatsCP.environmentalKills
            self.multiKills.text = self.playerStatsCP.multikills
            //Assists
            self.reconAssists.text = self.playerStatsCP.reconAssists
            self.healingDone.text = self.playerStatsCP.healingDone
            self.teleporterPadsDestroyed.text = self.playerStatsCP.teleporterPadsDestroyed
            //Best
            self.eliminationsMostInGame.text = self.playerStatsCP.eliminationsMostInGame
            self.finalBlowsMostInGame.text = self.playerStatsCP.finalBlowsMostInGame
            self.damageDoneMostInGame.text = self.playerStatsCP.damageDoneMostInGame
            self.healingDoneMostInGame.text = self.playerStatsCP.healingDoneMostInGame
            self.defensiveAssistsMostInGame.text = self.playerStatsCP.defensiveAssistsMostInGame
            self.offensiveAssistsMostInGame.text = self.playerStatsCP.offensiveAssistsMostInGame
            self.objectiveKillsMostInGame.text = self.playerStatsCP.objectiveKillsMostInGame
            self.objectiveTimeMostInGame.text = self.playerStatsCP.objectiveTimeMostInGame
            self.multikillBest.text = self.playerStatsCP.multikillBest
            self.soloKillsMostInGame.text = self.playerStatsCP.soloKillsMostInGame
            self.timeSpentOnFireMostInGame.text = self.playerStatsCP.timeSpentOnFireMostInGame
            //Average
            self.meleeFinalBlowsAverage.text = self.playerStatsCP.meleeFinalBlowsAverage
            self.timeSpentOnFireAverage.text = self.playerStatsCP.timeSpentOnFireAverage
            self.soloKillsAverage.text = self.playerStatsCP.soloKillsAverage
            self.objectiveTimeAverage.text = self.playerStatsCP.objectiveTimeAverage
            self.objectiveKillsAverage.text = self.playerStatsCP.objectiveKillsAverage
            self.healingDoneAverage.text = self.playerStatsCP.healingDoneAverage
            self.finalBlowsAverage.text = self.playerStatsCP.finalBlowsAverage
            self.deathsAverage.text = self.playerStatsCP.deathsAverage
            self.damageDoneAverage.text = self.playerStatsCP.damageDoneAverage
            self.eliminationsAverage.text = self.playerStatsCP.eliminationsAverage
            //Deaths
            self.deaths.text = self.playerStatsCP.deaths
            self.environmentalDeaths.text = self.playerStatsCP.environmentalDeaths
            //Match Awards
            self.cards.text = self.playerStatsCP.cards
            self.medals.text = self.playerStatsCP.medals
            self.medalsGold.text = self.playerStatsCP.medalsGold
            self.medalsSilver.text = self.playerStatsCP.medalsSilver
            self.medalsBronze.text = self.playerStatsCP.medalsBronze
            //Games
            self.gamesWon.text = self.playerStatsCP.gamesWon
            self.timeSpentOnFire.text = self.playerStatsCP.timeSpentOnFire
            self.objectiveTime.text = self.playerStatsCP.objectiveTime
            self.timePlayed.text = self.playerStatsCP.timePlayed
            //Misc
            self.meleeFinalBlowsMostInGame.text = self.playerStatsCP.finalBlowsMostInGame
            self.reconAssistsAverage.text = self.playerStatsCP.reconAssistsAverage
            self.defensiveAssists.text = self.playerStatsCP.defensiveAssists
            self.defensiveAssistsAverage.text = self.playerStatsCP.defensiveAssistsAverage
            self.offensiveAssists.text = self.playerStatsCP.offensiveAssists
            self.offensiveAssistsAverage.text = self.playerStatsCP.offensiveAssistsAverage
        }
    }
    
    //Visual
    func repeatBackground() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { [weak self] _ in
            self?.backgroundTransition()
        }
    }
    
    //Cycle through saved images for wallpaper.
    func backgroundTransition() {
        let rolls = arc4random_uniform(27) + 1
        let toImage = UIImage(named:"\(rolls)")
        
        UIView.transition(with: dynamicBG,
                          duration: 1.5,
                          options: [.transitionCrossDissolve],
                          animations: { self.dynamicBG.image = toImage },
                          completion: nil)
    }

}
