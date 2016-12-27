//
//  AchievementsVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/11/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire

class AchievementsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //API URL
    let url = UserDefaults.standard.string(forKey: "playerAchievements")

    
    //Variables
    weak var timer: Timer?
    
    //Outlets
    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var finishedLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var heroAchievementData = [PlayerAchievements]()
    var playerAchievements: PlayerAchievements!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        downloadAchievementData {
            print("Accessed player Achievement data.")
        }
        
    }
    
    //Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroAchievementData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "achievementCell", for: indexPath) as? AchievementCell {
            DispatchQueue.main.async {
                let playerAchievementData = self.heroAchievementData[indexPath.row]
                cell.configureCell(playerAchievements: playerAchievementData)
            }
                return cell
        } else {
            return AchievementCell()
        }
    }
    
    //Parse API Data
    
    
    func downloadAchievementData(completed: @escaping DownloadComplete) {
        Alamofire.request(url!).responseJSON { response in
            let data = response.result
            if let JSON = data.value as? Dictionary<String, AnyObject> {
                if let finished = JSON["finishedAchievements"] as? String {
                    self.finishedLbl.text = finished
                }
                if let achievement = JSON["achievements"] as? [[String: AnyObject]] {
                    for items in achievement {
                        let achievementData = PlayerAchievements(heroAchDict: [items])
                        self.heroAchievementData.append(achievementData)
                    }
                    self.tableView.reloadData()
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
