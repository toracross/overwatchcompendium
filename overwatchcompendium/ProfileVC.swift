//
//  ProfileVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/19/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProfileVC: UIViewController {

    //API URL + Saved Data
    let url = UserDefaults.standard.string(forKey: "playerProfile")
    let playerPlatformLbl = UserDefaults.standard.string(forKey: "playerPlatform")
    let playerRegionLbl = UserDefaults.standard.string(forKey: "playerRegion")
    
    //Variables
    weak var timer: Timer?
    var playerData: PlayerProfileData!
    
    //Outlets
    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerRegion: UILabel!
    @IBOutlet weak var playerAvatar: UIImageView!
    @IBOutlet weak var playerQPWins: UILabel!
    @IBOutlet weak var playerCPWins: UILabel!
    @IBOutlet weak var playerQPTime: UILabel!
    @IBOutlet weak var playerCPTime: UILabel!
    @IBOutlet weak var playerCPLoss: UILabel!
    @IBOutlet weak var playerCPTotal: UILabel!
    @IBOutlet weak var playerRank: UILabel!
    @IBOutlet weak var playerRankImg: UIImageView!
    @IBOutlet weak var playerLevel: UILabel!
    @IBOutlet weak var playerLevelImg: UIImageView!
    @IBOutlet weak var playerStar: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerData = PlayerProfileData()        
        playerData.downloadPlayerStats {
            self.updateUI()
        }
        repeatBackground()
    }
    
    
    func updateUI() {
        //Stats
        playerName.text = playerData.playerName
        playerRegion.text = "\(playerPlatformLbl!) \(playerRegionLbl!)"
        playerLevel.text = "\(playerData.playerLevel)"
        
        //Quickplay
        playerQPWins.text = "\(playerData.playerQPWins) wins"
        playerQPTime.text = "Playtime: \(playerData.playerQPTime)"
        
        //Competitive
        playerCPWins.text = "\(playerData.playerCPWins) games won"
        playerCPLoss.text = "\(playerData.playerCPLoss) games lost"
        playerCPTotal.text = "\(playerData.playerCPTotal) games played"
        playerCPTime.text = "Playtime: \(playerData.playerCPTime)"
        playerRank.text = "Rank: \(playerData.playerRank)"
        
        //Images
        //Level
        if let levelUrl = URL(string: playerData.playerLevelImg) {
            do {
                let levelData = try Data(contentsOf: levelUrl)
                self.playerLevelImg.image = UIImage(data: levelData)
            } catch {
                print("Could not find image file.")
            }
        }
        
        //Avatar
        if let avatarUrl = URL(string: playerData.playerAvatar) {
            do {
                let avatarData = try Data(contentsOf: avatarUrl)
                self.playerAvatar.image = UIImage(data: avatarData)
            } catch {
                print("Could not find image file.")
            }
        }

        
        //Rank
        if let rankUrl = URL(string: playerData.playerRankImg) {
            do {
                let rankData = try Data(contentsOf: rankUrl)
                self.playerRankImg.image = UIImage(data: rankData)
            } catch {
                print("Could not find image file.")
            }
        }

        
        //Star - Player may not be lv100+, don't want to crash.
        if let starUrl = URL(string: playerData.playerStar) {
            do {
                let starData = try Data(contentsOf: starUrl)
                self.playerStar.image = UIImage(data: starData)
            } catch {
                print("Could not find image file.")
            }
        }
    }
    
    //Return to previous view controller.
    @IBAction func returnToSearch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
