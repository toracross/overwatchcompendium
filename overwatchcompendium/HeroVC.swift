//
//  HeroVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/11/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class HeroVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NVActivityIndicatorViewable {
    
    //API URL
    let urlQP = UserDefaults.standard.string(forKey: "playerHeroesQP")
    let urlCP = UserDefaults.standard.string(forKey: "playerHeroesCP")
    
    var heroTableDataQP = [PlayerHeroesQP]()
    var heroTableDataCP = [PlayerHeroesCP]()
    var playerHeroesQP: PlayerHeroesQP!
    
    var heroCPData = [Dictionary<String, AnyObject>]()
    var heroQPData = [Dictionary<String, AnyObject>]()
    
    weak var timer: Timer?
    
    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gameModeControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        startAnimating(message: "Loading...")
        downloadPlayerQPStats {
            print("Accessing player quickplay data.")
            self.downloadPlayerCPStats {
                print("Accessing player comp data.")
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
                    self.heroQPData = [items]
                }
                self.tableView.reloadData()
                self.stopAnimating()
            }
            
        }
        completed()
    }
    
    func downloadPlayerCPStats(completed: @escaping DownloadComplete) {
        Alamofire.request(urlCP!).responseJSON { response in
            let download = response.result
            if let JSON = download.value as? [Dictionary<String, AnyObject>] {
                for items in JSON {
                    let heroData = PlayerHeroesCP(heroCPDict: [items])
                    self.heroTableDataCP.append(heroData)
                    self.heroCPData = [items]
                }
            }
        }
        completed()
    }
    
    
    func updateQPUI() {
        DispatchQueue.main.async {
        }
    }
    
    func updateCPUI() {
        DispatchQueue.main.async {
            self.downloadPlayerCPStats {
                self.tableView.reloadData()
            }
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
