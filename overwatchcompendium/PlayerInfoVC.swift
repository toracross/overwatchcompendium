//
//  PlayerInfoVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/13/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.
//

import UIKit

class PlayerInfoVC: UIViewController {

    
    
    @IBOutlet weak var playerName: CustomLblTitle!
    
    var statsModel: PlayerModel!
    var savedPlayerName = UserDefaults.standard.string(forKey: "playerName")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerName.text = savedPlayerName!.replacingOccurrences(of: "-", with: "#")
        
        statsModel = PlayerModel()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
