//
//  CheckConnectionVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/18/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire

class CheckConnectionVC: UIViewController {
    
    @IBOutlet weak var staticBg: UIImageView!
    
    var avgcost: Bool = true
    let url = "https://toracross.com/api/v1/foodtruck"
    let downloadDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkResourceForSegue {
            print("Accessing my API.")
            
            self.checkCostAndSegue()
        }
    }
    
    func checkResourceForSegue(completed: @escaping DownloadComplete) {
        Alamofire.request(url).responseJSON { response in
            let download = response.result
            if let JSON = download.value as? [Dictionary<String, AnyObject>] {
                self.avgcost = JSON[0]["avgcost"] as! Bool
                self.downloadDefaults.set(self.avgcost, forKey: "apiKey")
                print(self.avgcost)
            }
            
        completed()
        }
        
    }
    
    func checkCostAndSegue() {
        if avgcost == false {
            performSegue(withIdentifier: "fullSegue", sender: nil)
        } else if avgcost == true {
            performSegue(withIdentifier: "partialSegue", sender: nil)
        } else  {
            
        }
    }

}
