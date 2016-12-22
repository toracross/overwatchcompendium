//
//  StatsVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/11/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class StatsVC: UIViewController {

    //API URL
    let urlQP = UserDefaults.standard.string(forKey: "playerStatsQP")
    let urlCP = UserDefaults.standard.string(forKey: "playerStatsCP")
    
    //Variables
    weak var timer: Timer?
    var playerStatsQP: PlayerStatsQP!
    
    //Outlets
    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var meleeFinalBlows: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerStatsQP = PlayerStatsQP()
        playerStatsQP.downloadPlayerQPStats {
            print("Data download was...")
            self.updateUI()
            
        }
        repeatBackground()
    }
    
    //Update UI
    func updateUI() {
        self.meleeFinalBlows.text = playerStatsQP.meleeFinalBlows
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
