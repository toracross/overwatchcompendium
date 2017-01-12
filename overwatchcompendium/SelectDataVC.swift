//
//  SelectDataVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/9/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class SelectDataVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var battleTxt: UITextField!
    @IBOutlet weak var platformControl: UISegmentedControl!
    @IBOutlet weak var regionControl: UISegmentedControl!
    
    
    //Model Classes
    var playerStatsQP = PlayerStatsQP()
    var playerStatsCP = PlayerStatsCP()
    
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
        
        startAnimating(message:"Loading...")
        let name = battleTxt.text
        
            switch platformControl.selectedSegmentIndex {
            case 0: platformTxt = "pc"
            case 1: platformTxt = "psn"
            case 2: platformTxt = "xbl"
            default:
                break
            }
            
            switch regionControl.selectedSegmentIndex {
            case 0: regionTxt = "us"
            case 1: regionTxt = "eu"
            default:
                break
            }
        
        //Save Platform
        let playerPlatform = platformTxt
        let playerRegion = regionTxt
        defaults.set(playerPlatform, forKey: "playerPlatform")
        defaults.set(playerRegion, forKey: "playerRegion")
        
        //Save Profile
        let playerProfile = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)/profile"
        defaults.set(playerProfile, forKey: "playerProfile")
        
        //Save Stats
        //Quickplay
        let playerStatsQP = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)/quickplay/allHeroes/"
        defaults.set(playerStatsQP, forKey: "playerStatsQP")
        //Competitive
        let playerStatsCP = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)/competitive/allHeroes/"
        defaults.set(playerStatsCP, forKey: "playerStatsCP")
        
        //Save Heroes
        //Quickplay
        let playerHeroesQP = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)/quickplay/heroes"
        defaults.set(playerHeroesQP, forKey: "playerHeroesQP")
        //Competitive
        let playerHeroesCP = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)/competitive/heroes"
        defaults.set(playerHeroesCP, forKey: "playerHeroesCP")

        //Save Achievements
        let playerAchievements = "https://api.lootbox.eu/\(platformTxt)/\(regionTxt)/\(battleTxt.text!)/achievements"
        defaults.set(playerAchievements, forKey: "playerAchievements")
        
        //check URL
        func checkStatusCode(completed: @escaping DownloadComplete) {
            let responseCode = 404
            
            Alamofire.request(playerProfile).responseJSON { response in
                let httpResponse = response.result
                
                if let errorCode = httpResponse.value as? Dictionary<String, AnyObject> {
                    if let statusCode = errorCode["statusCode"] as? Int {
                        print(statusCode)
                        if statusCode != responseCode {
                            print("Never called.")
                        }
                        else {
                            self.stopAnimating()
                            self.alertFailMessage()
                        }
                    }
                }
                completed()
            }
        }

        
        checkStatusCode {
            if name != "" {
                //Download literally everything.
                self.playerStatsQP.downloadPlayerQPStats {
                    print("Downloaded player quickplay stats.")
                }
                self.playerStatsCP.downloadPlayerCPStats {
                    print("Downloaded player comp stats.")
                }
                self.stopAnimating()
                self.performSegue(withIdentifier: "playerInfo", sender: self)
                
            } else {
                print("No data called.")
            }
        }
        
    }
    
    func checkTestUrl(completed: @escaping DownloadComplete) {
        let testUrl = "https://overwatch-api.net/api/v1/map/6"
        
        Alamofire.request(testUrl).responseJSON { response in
            let data = response.result
            
            if let JSON = data.value as? Dictionary<String, AnyObject> {
                print(JSON)
                if let stages = JSON["stages"] as? [Dictionary<String, AnyObject>] {
                    print("Stages")
                    print(stages)
                }
            }
            
        }
        completed()
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
    
    //Alert if status is not SUCCESS.
    func alertFailMessage() {
        let alert = UIAlertController(title: "Profile not found.",
                                      message: "No data was returned for this battle tag, please make sure the player name is valid and try again.",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "CLOSE", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}
