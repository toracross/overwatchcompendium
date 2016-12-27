//
//  HeroVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/11/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire

class HeroVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //API URL
    let urlQP = UserDefaults.standard.string(forKey: "playerHeroesQP")
    
    var heroTableDataQP = [PlayerHeroesQP]()
    var playerHeroesQP: PlayerHeroesQP!
    
    weak var timer: Timer?
    
    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        downloadPlayerQPStats {
            print("Accessing player data.")
        }
        
        repeatBackground()
    }
    
    //Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroTableDataQP.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath) as? HeroCell {
            let playerDataQP = heroTableDataQP[indexPath.row]
            cell.configureCell(playerHeroesQP: playerDataQP)
            return cell
        } else {
            return HeroCell()
        }
    }

    //Parse Data
    
    func downloadPlayerQPStats(completed: @escaping DownloadComplete) {
        Alamofire.request(urlQP!).responseJSON { response in
            let download = response.result
            if let JSON = download.value as? [Dictionary<String, AnyObject>] {
                for items in JSON {
                    let heroData = PlayerHeroesQP(heroQPDict: [items])
                    self.heroTableDataQP.append(heroData)
                }
                self.tableView.reloadData()
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
