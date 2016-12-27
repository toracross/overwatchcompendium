//
//  AchievementCell.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/25/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class AchievementCell: UITableViewCell {
    
    var playerAchievements: PlayerAchievements!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var finishedLbl: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func configureCell(playerAchievements: PlayerAchievements) {
        nameLbl.text = playerAchievements.achName
        
        if playerAchievements.achFinished == true {
            finishedLbl.text = "Earned: Yes"
        } else if playerAchievements.achFinished == false {
            finishedLbl.text = "Earned: No"
        }
        
        if let achUrl = URL(string: playerAchievements.achImage) {
            do {
                let achData = try Data(contentsOf: achUrl)
                self.iconImg.image = UIImage(data: achData)
            } catch {
                print("Could not find image file.")
            }
        }
        
        descriptionLbl.text = playerAchievements.achDescription
        
    }
}
