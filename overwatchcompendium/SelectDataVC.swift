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
    
    @IBOutlet weak var titleLbl: CustomLblTitle!
    @IBOutlet weak var dynamicBG: UIImageView!
    @IBOutlet weak var battleTxt: UITextField!
    @IBOutlet weak var tagTxt: UITextField!
    @IBOutlet weak var platformControl: UISegmentedControl!
    
    
    weak var timer: Timer?
    var platformTxt = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadTestData {
            print("Successfully downloaded data")
        }
        
        repeatBackground()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Grab inputted data, perform download, move to next segue to display downloaded data.
    @IBAction func downloadBtnPushed(_ sender: UIButton) {
        
        let name = battleTxt.text
        let number = tagTxt.text
        
        if name != "" && number != "" {
            if platformControl.selectedSegmentIndex == 0 {
                platformTxt = "pc"
            } else if platformControl.selectedSegmentIndex == 1 {
                platformTxt = "psn"
            } else if platformControl.selectedSegmentIndex == 2 {
                platformTxt = "xbl"
            }
            
            let URL = "\(BASE_URL)\(name!)\(BTAG_MID)\(number!)\(END_URL)\(PLATFORM_URL)\(platformTxt)"
            print("The full URL is: \(URL)")
        
            
            //If both fields are valid, perform segue to next part.
            performSegue(withIdentifier: "playerInfo", sender: nil)
        } else {
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

    
    //Test Data
    
    let url = "https://owapi.net/api/v3/u/Lunar-1617/blob"
    
    func downloadTestData(completed: @escaping DownloadComplete) {
        Alamofire.request(url).responseJSON { response in
            print(response.request!)
            print(response.response!)
            print(response.data!)
            print(response.result)
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    
    
    
    
    

}






