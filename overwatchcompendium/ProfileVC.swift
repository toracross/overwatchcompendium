//
//  ProfileVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/19/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire

class ProfileVC: UIViewController {

    //API URL
    let url = UserDefaults.standard.string(forKey: "playerProfile")
    
    //Variables
    weak var timer: Timer?
    
    //Outlets
    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerRegion: UILabel!
    @IBOutlet weak var playerAvatar: UIImageView!
    @IBOutlet weak var playerQPWins: UILabel!
    @IBOutlet weak var playerCPWins: UILabel!
    @IBOutlet weak var playerRank: UILabel!
    @IBOutlet weak var playerRankImg: UIImageView!
    @IBOutlet weak var playerLevel: UILabel!
    @IBOutlet weak var playerLevelImg: UIImageView!
    @IBOutlet weak var playerStar1: UIImageView!
    @IBOutlet weak var playerStar2: UIImageView!
    @IBOutlet weak var playerStar3: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repeatBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        downloadPlayerStats {
            print("Downloaded Player Stats.")
        }
    }

    
    //Parse API Data
    func downloadPlayerStats(completed: @escaping DownloadComplete) {
        Alamofire.request(url!).responseJSON { response in
            let download = response.result
            if let JSON = download.value as? Dictionary<String, AnyObject> {
                if let data = JSON["data"] as? Dictionary<String, AnyObject> {
                    
                    if let username = data["username"] as? String {
                        self.playerName.text = username
                    }
                    if let level = data["level"] as? Int {
                        self.playerLevel.text = "\(level)"
                    }
                    
                    if let games = data["games"] as? Dictionary<String, AnyObject> {
                        if let quickplay = games["quick"] as? Dictionary<String, AnyObject> {
                            if let wins = quickplay["wins"] as? String {
                                self.playerQPWins.text = "\(wins) winste"
                            }
                        }
                    }
                    
                }
                
            }
            
        }
        completed()
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
