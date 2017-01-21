//
//  AchievementCell.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/19/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.
//

import UIKit

class AchievementCell: UICollectionViewCell {
    
    var statsModel = PlayerModel()
    let darkYellow = UIColor(red: 187/255.0, green: 131/255.0, blue: 62/255.0, alpha: 1)
    
    @IBOutlet weak var achievementName: UILabel!
    @IBOutlet weak var achievementImg: UIImageView!
    @IBOutlet weak var achievementEarned: UIImageView!
    
    override func awakeFromNib() {
        self.layer.borderWidth = 2
        self.layer.borderColor = darkYellow.cgColor
        self.layer.cornerRadius = 3
    }

}
