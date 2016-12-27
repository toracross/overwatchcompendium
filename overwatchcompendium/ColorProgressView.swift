//
//  ColorProgressView.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/24/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class ColorProgressView: UIProgressView {
 
    let darkYellow = UIColor(red: 187/255.0, green: 131/255.0, blue: 62/255.0, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = darkYellow.cgColor
        self.trackTintColor = UIColor.clear
    }
    
}
