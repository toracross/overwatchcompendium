//
//  NavigationVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/11/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire

class NavigationVC: UIViewController {

    @IBOutlet weak var dynamicBG: UIImageView!
    
    weak var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repeatBackground()
    }

    @IBAction func heroBtnPushed(_ sender: Any) {
        self.performSegue(withIdentifier: "heroSegue", sender: self)
    }
    
    
    @IBAction func playerBtnPushed(_ sender: Any) {
        self.performSegue(withIdentifier: "playerSearchSegue", sender: self)
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
}
