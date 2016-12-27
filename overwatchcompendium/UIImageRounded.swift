//
//  UIImageRounded.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/21/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class UIImageRounded: UIImageView {
    
    let darkYellow = UIColor(red: 187/255.0, green: 131/255.0, blue: 62/255.0, alpha: 1)
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 1
        
        self.layer.borderWidth = 3
        self.layer.shadowRadius = 1
        self.layer.borderColor = darkYellow.cgColor
    }
    
}
