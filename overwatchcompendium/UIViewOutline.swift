//
//  UIViewOutline.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/20/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class UIViewOutline: UIView {
    
    override func awakeFromNib() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.yellow.cgColor
        
        self.layer.cornerRadius = 3
        self.layer.shadowOpacity = 1
    }
    
}
