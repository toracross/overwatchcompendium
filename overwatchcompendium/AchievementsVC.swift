//
//  AchievementsVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/11/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire

class AchievementsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //API URL
    let url = UserDefaults.standard.string(forKey: "playerAchievements")
    
    //Variables
    weak var timer: Timer?
    
    //Outlets
    @IBOutlet weak var dynamicBG: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()


        repeatBackground()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchCell", for: indexPath) as? AchievementCell {
            //code goes here
            
            return cell
        } else {
            return AchievementCell()
        }
        
    }
    
    func downloadAchievementData(completed: @escaping DownloadComplete) {
        Alamofire.request("").responseJSON { response in
            let data = response.result
            //print(data) - works
            
            if let JSON = data.value as? Dictionary<String, AnyObject> {
                //print(JSON) - works
                if let achievement = JSON["achievements"] as? [[String: AnyObject]] {
                    //print(achievement) //- works
                    
                    for items in achievement {
                        if let name = items["name"] as? String {
                            //self.names.append(name)
                        }
                        if let description = items["description"] as? String {
                           //self.descriptions.append(description)
                        }
                        if let finished = items["finished"] as? Bool {
                            //self.finished.append(finished)
                        }
                        
                    }
                    /*
                    print(self.names)
                    print(self.descriptions)
                    print(self.finished)
                    */
                    
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
