//
//  SelectDataVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/9/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire


class SelectDataVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var battleTxt: UITextField!
    @IBOutlet weak var tagTxt: UITextField!
    @IBOutlet weak var platformControl: UISegmentedControl!
    @IBOutlet weak var regionControl: UISegmentedControl!
    
    weak var timer: Timer?
    var platformTxt = ""
    var regionTxt = ""
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        repeatBackground()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Grab inputted data, perform download, move to next segue to display downloaded data.
    @IBAction func downloadBtnPushed(_ sender: UIButton) {
        
        let name = battleTxt.text
        let number = tagTxt.text
        
        if (name!.isEmpty) || (number!.isEmpty) {
            
            alertMessage()
            
        } else {
            
            if platformControl.selectedSegmentIndex == 0 && regionControl.selectedSegmentIndex == 0 {
                platformTxt = "pc"; regionTxt = "us";
            }
            if platformControl.selectedSegmentIndex == 0 && regionControl.selectedSegmentIndex == 1 {
                platformTxt = "pc"; regionTxt = "eu";
            }
            if platformControl.selectedSegmentIndex == 1 && regionControl.selectedSegmentIndex == 0 {
                platformTxt = "psn"; regionTxt = "us";
            }
            if platformControl.selectedSegmentIndex == 1 && regionControl.selectedSegmentIndex == 1 {
                platformTxt = "psn"; regionTxt = "eu";
            }
            if platformControl.selectedSegmentIndex == 2 && regionControl.selectedSegmentIndex == 0 {
                platformTxt = "xbl"; regionTxt = "us";
            }
            if platformControl.selectedSegmentIndex == 2 && regionControl.selectedSegmentIndex == 1 {
                platformTxt = "xbl"; regionTxt = "eu";
            }
            
        }
        
        //Save Profile
        let playerProfile = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)-\(tagTxt.text!)/profile"
        defaults.set(playerProfile, forKey: "playerProfile")
        
        //Save Stats
        //Quickplay
        let playerStatsQP = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)-\(tagTxt.text!)/quickplay/allHeroes"
        defaults.set(playerStatsQP, forKey: "playerStatsQP")
        //Competitive
        let playerStatsCP = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)-\(tagTxt.text!)/competitive/allHeroes"
        defaults.set(playerStatsCP, forKey: "playerStatsCP")
        
        //Save Heroes
        //Quickplay
        let playerHeroesQP = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)-\(tagTxt.text!)/quickplay/heroes"
        defaults.set(playerHeroesQP, forKey: "playerHeroesQP")
        //Competitive
        let playerHeroesCP = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)-\(tagTxt.text!)/competitive/heroes"
        defaults.set(playerHeroesCP, forKey: "playerHeroesCP")

        //Save Achievements
        let playerAchievements = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)-\(tagTxt.text!)/achievements"
        defaults.set(playerAchievements, forKey: "playerAchievements")
        
        self.performSegue(withIdentifier: "playerInfo", sender: self)
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
        let toImage = UIImage(named:"\(rolls)")
        
        UIView.transition(with: dynamicBG,
                          duration: 1.5,
                          options: [.transitionCrossDissolve],
                          animations: { self.dynamicBG.image = toImage },
                          completion: nil)
    }
    
    //Dismiss keyboard on tap
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func alertMessage() {
        //Fire an alert indicating the user didn't fill in all fields.
        let alert = UIAlertController(title: "Battle Tag missing.",
                                      message: "Either your name or number tag is missing, please fill in that data.",
                                      preferredStyle: UIAlertControllerStyle.alert)
         
         alert.addAction(UIAlertAction(title: "OK",
                                       style: UIAlertActionStyle.default,
                                       handler: nil))
         self.present(alert, animated: true, completion: nil)
    }
}






