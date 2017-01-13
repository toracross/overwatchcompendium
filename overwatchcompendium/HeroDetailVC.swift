//
//  HeroDetailVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/12/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.
//

import UIKit

class HeroDetailVC: UIViewController {
    
    let selectedHero = UserDefaults.standard.string(forKey: "selectedHero")
    
    @IBOutlet weak var heroName: CustomLblTitle!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroName.text = selectedHero!
    }

    
    @IBAction func backBtnPushed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
