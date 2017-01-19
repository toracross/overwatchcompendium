//
//  UITableViewOutline.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/19/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.
//

import UIKit

class UITableViewOutline: UITableView {
    
    let darkYellow = UIColor(red: 187/255.0, green: 131/255.0, blue: 62/255.0, alpha: 1)
    
    override func awakeFromNib() {
        self.layer.borderWidth = 2
        self.layer.borderColor = darkYellow.cgColor
    }
    
}
