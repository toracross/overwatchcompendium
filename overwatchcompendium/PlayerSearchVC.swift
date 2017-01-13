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
    
    weak var timer: Timer?
    var regionTxt: String!
    var platformTxt: String!
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repeatBackground()
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func searchBtnPushed(_ sender: Any) {
        startAnimating(message: "Loading...")
        
        let name = battleTagTxt.text
        
        switch platformSegment.selectedSegmentIndex {
        case 0:
            platformTxt = "pc"
        case 1:
            platformTxt = "psn"
        case 2:
            platformTxt = "xbl"
        default:
            break
        }
        
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
        
        //Download URL:
        // https://toracross.com/api/v3/u/\(name)/blob?platform=\(platformTxt)
        
        //Save Player Name
        defaults.set(name, forKey: "playerName")
        defaults.set(regionTxt, forKey: "playerRegion")
        
        func checkStatusCode(completed: @escaping DownloadComplete) {
            let responseCode = 404
            let url = "https://toracross.com/api/v3/u/\(name!)/blob?platform=\(platformTxt!)"
            print(url)
            Alamofire.request(url).responseJSON { response in
                let httpResponse = response.result
                print(httpResponse)
                if let errorCode = httpResponse.value as? Dictionary<String, AnyObject> {
                    if let statusCode = errorCode ["error"] as? Int {
                        print(statusCode)
                        if statusCode != responseCode {
                            print("Not called. Ever.")
                        } else {
                            print("This 404'd.")
                            self.stopAnimating()
                            self.alertFailMessage()
                        }
                    }
                }
                completed()
            }
        }
        
        checkStatusCode { DownloadComplete in
            if name != "" {
                //Download literally everything.
                
            } else {
                print("Name was left blank.")
                self.alertFailMessage()
            }
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
    
    @IBAction func backBtnPushed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
