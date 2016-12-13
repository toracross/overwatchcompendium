//
//  HeroVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/11/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class HeroVC: UIViewController {
    
    weak var timer: Timer?
    
    @IBOutlet weak var dynamicBG: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
