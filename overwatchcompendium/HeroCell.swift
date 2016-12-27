//
//  HeroCell.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/24/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class HeroCell: UITableViewCell {
    
    var playerHeroesQP: PlayerHeroesQP!
    
    @IBOutlet weak var heroImg: UIImageView!
    @IBOutlet weak var heroPlaytime: CustomLblTitle!
    @IBOutlet weak var heroPercentage: UIProgressView!
    @IBOutlet weak var heroName: CustomLblTitle!
    
    func configureCell(playerHeroesQP: PlayerHeroesQP) {
        self.heroPercentage.progress = playerHeroesQP.percentage
        heroName.text = playerHeroesQP.name
        heroPlaytime.text = playerHeroesQP.playtime
        heroImg.image = UIImage(named: playerHeroesQP.image)

        configureHeroColor()
    }
    
    func configureHeroColor() {
        if heroName.text != nil {
            let firstHero = heroName.text?.replacingOccurrences(of: "Soldier: 76", with: "Soldier 76")
            let secondHero = firstHero?.replacingOccurrences(of: "Torbjörn", with: "Torbjorn")
            let thirdHero = secondHero?.replacingOccurrences(of: "Lúcio", with: "Lucio")
            heroPercentage.progressImage = UIImage(named: thirdHero!)
        }
    }
    
}
