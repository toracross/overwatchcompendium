//
//  UIViewOutline.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/20/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class UIViewOutline: UIView {
    
    let darkYellow = UIColor(red: 187/255.0, green: 131/255.0, blue: 62/255.0, alpha: 1)
    
    override func awakeFromNib() {
        self.layer.borderWidth = 2
        self.layer.borderColor = darkYellow.cgColor
        
        self.layer.cornerRadius = 3
        self.layer.shadowOpacity = 1
        
        
    }
    
}
