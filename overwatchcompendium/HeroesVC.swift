//
//  HeroesVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/12/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.
//

import UIKit

class HeroesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var roleSegment: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var timer: Timer?
    let defaults = UserDefaults.standard
    var allHeroNames = ["Genji", "McCree", "Pharah", "Reaper", "Soldier 76", "Sombra", "Tracer", "Bastion", "Hanzo", "Junkrat", "Mei", "Torbjorn", "Widowmaker", "D.Va", "Reinhardt", "Roadhog", "Winston", "Zarya", "Ana", "Lucio", "Mercy", "Symmetra", "Zenyatta"]
    var offenseHeroNames = ["Genji", "McCree", "Pharah", "Reaper", "Soldier 76", "Sombra", "Tracer"]
    var defenseHeroNames = ["Bastion", "Hanzo", "Junkrat", "Mei", "Torbjorn", "Widowmaker"]
    var tankHeroNames = ["D.Va", "Reinhardt", "Roadhog", "Winston", "Zarya"]
    var supportHeroNames = ["Ana", "Lucio", "Mercy", "Symmetra", "Zenyatta"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repeatBackground()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @IBAction func roleSegmentSelected(_ sender: Any) {
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch roleSegment.selectedSegmentIndex {
        case 0:
            return self.allHeroNames.count
        case 1:
            return self.offenseHeroNames.count
        case 2:
            return self.defenseHeroNames.count
        case 3:
            return self.tankHeroNames.count
        case 4:
            return self.supportHeroNames.count
        default:
            self.collectionView.reloadData()
            break
        }
        return roleSegment.selectedSegmentIndex
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroesCell
        
        switch roleSegment.selectedSegmentIndex {
        case 0:
            let name = self.allHeroNames[indexPath.item]
            cell.heroName.text = name
            cell.heroImg.image = UIImage(named: "\(name)")
        case 1:
            let name = self.offenseHeroNames[indexPath.item]
            cell.heroName.text = name
            cell.heroImg.image = UIImage(named: "\(name)")
        case 2:
            let name = self.defenseHeroNames[indexPath.item]
            cell.heroName.text = name
            cell.heroImg.image = UIImage(named: "\(name)")
        case 3:
            let name = self.tankHeroNames[indexPath.item]
            cell.heroName.text = name
            cell.heroImg.image = UIImage(named: "\(name)")
        case 4:
            let name = self.supportHeroNames[indexPath.item]
            cell.heroName.text = name
            cell.heroImg.image = UIImage(named: "\(name)")
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch roleSegment.selectedSegmentIndex {
        case 0:
            let selectedHero = self.allHeroNames[indexPath.item]
            defaults.set(selectedHero, forKey: "selectedHero")
            performSegue(withIdentifier: "heroSelected", sender: self)
        case 1:
            let selectedHero = self.offenseHeroNames[indexPath.item]
            defaults.set(selectedHero, forKey: "selectedHero")
            performSegue(withIdentifier: "heroSelected", sender: self)
        case 2:
            let selectedHero = self.defenseHeroNames[indexPath.item]
            defaults.set(selectedHero, forKey: "selectedHero")
            performSegue(withIdentifier: "heroSelected", sender: self)
        case 3:
            let selectedHero = self.tankHeroNames[indexPath.item]
            defaults.set(selectedHero, forKey: "selectedHero")
            performSegue(withIdentifier: "heroSelected", sender: self)
        case 4:
            let selectedHero = self.supportHeroNames[indexPath.item]
            defaults.set(selectedHero, forKey: "selectedHero")
            performSegue(withIdentifier: "heroSelected", sender: self)
        default:
            break
        }
    }
    
    //Put background on a timer, cycle to next every x seconds.
    func repeatBackground() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { [weak self] _ in
            self?.backgroundTransition()
        }
    }
    
    //Cycle through saved images for wallpaper.
    func backgroundTransition() {
        let rolls = arc4random_uniform(27) + 1
        let toImage = UIImage(named:"wp\(rolls)")
        
        UIView.transition(with: dynamicBG,
                          duration: 1.5,
                          options: [.transitionCrossDissolve],
                          animations: { self.dynamicBG.image = toImage },
                          completion: nil)
    }
    
    @IBAction func backBtnPushed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
