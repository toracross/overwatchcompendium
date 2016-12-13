//
//  AchievementsVC.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/11/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire

class AchievementsVC: UIViewController {

    //Variables
    weak var timer: Timer?
    
    
    //Outlets
    @IBOutlet weak var dynamicBG: UIImageView!
    
    //TableViews
    @IBOutlet weak var offenseTableView: UITableView!
    @IBOutlet weak var defenseTableView: UITableView!
    @IBOutlet weak var tankTableView: UITableView!
    @IBOutlet weak var supportTableView: UITableView!
    @IBOutlet weak var generalTableView: UITableView!
    @IBOutlet weak var mapsTableView: UITableView!
    @IBOutlet weak var specialTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        repeatBackground()
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
