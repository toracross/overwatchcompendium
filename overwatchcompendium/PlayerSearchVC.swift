//
//  PlayerSearchVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/13/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class PlayerSearchVC: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var battleTagTxt: UITextField!
    @IBOutlet weak var platformSegment: UISegmentedControl!
    @IBOutlet weak var regionSegment: UISegmentedControl!
    @IBOutlet weak var backBtn: RoundedCorner!
    
    weak var timer: Timer?
    var regionTxt: String!
    var platformTxt: String!
    var defaults = UserDefaults.standard
    var validProfile = false
    let downloadDefaults = UserDefaults.standard.bool(forKey: "apiKey")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repeatBackground()
        
        self.backBtn.isHidden = downloadDefaults
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stopAnimating()
        self.validProfile = false
    }
    
    
    
    @IBAction func searchBtnPushed(_ sender: Any) {
        
        startAnimating(message: "Loading...")
        let name = battleTagTxt.text!.replacingOccurrences(of: "#", with: "-")
        
        if name.isEmpty != true {
            switch regionSegment.selectedSegmentIndex {
            case 0:
                regionTxt = "us"
            case 1:
                regionTxt = "eu"
            case 2:
                regionTxt = "kr"
            default:
                break
            }
            
            switch platformSegment.selectedSegmentIndex {
            case 0:
                platformTxt = "pc"
            case 1:
                platformTxt = "psn"
                regionTxt = "any"
            case 2:
                platformTxt = "xbl"
                regionTxt = "any"
            default:
                break
            }
            
            //Download URL:
            // https://toracross.com/api/v3/u/\(name)/blob?platform=\(platformTxt)
            
            //Save Player Name
            defaults.set(name, forKey: "playerName")
            defaults.set(regionTxt!, forKey: "playerRegion")
            defaults.set(platformTxt!, forKey: "playerPlatform")
            
            //Check player inputted data.
            func checkStatusCode(completed: @escaping DownloadComplete) {
                let url = "https://toracross.com/api/v3/u/\(name)/blob?platform=\(platformTxt!)"
                
                Alamofire.request(url).responseJSON { response in
                    let data = response.response?.statusCode
                    let download = response.result.value
                    
                    print(data!)
                    if data != 404 {
                        if let JSON = download as? Dictionary<String, AnyObject> {
                            if let region = JSON["\(self.regionTxt!)"] as? Dictionary<String, AnyObject> {
                                if let stats = region["stats"] as? Dictionary<String, AnyObject> {
                                    if let quickplay = stats["quickplay"] as? [String: AnyObject] {
                                        print(quickplay.count)
                                        if quickplay.count != 0 {
                                            print("There's data here.")
                                            self.validProfile = true
                                        } else {
                                            self.stopAnimating()
                                            self.alertFailMessage()
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        self.stopAnimating()
                        self.alertFailMessage()
                    }
                    completed()
                }
            }
            
            
            checkStatusCode { DownloadComplete in
                
                if self.validProfile != false {
                    print("Data will be returned")
                    self.performSegue(withIdentifier: "playerDataSegue", sender: nil)
                } 
            }

        } else {
            self.stopAnimating()
            alertFailMessage()
        }
    }
    
    @IBAction func platformSegControl(_ sender: Any) {
        switch platformSegment.selectedSegmentIndex {
        case 0:
            regionSegment.isHidden = false
        case 1:
            regionSegment.isHidden = true
        case 2:
            regionSegment.isHidden = true
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
    
    @IBAction func backBtnPushed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
