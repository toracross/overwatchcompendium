//
//  CustomTitle.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/9/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class CustomLblTitle: UILabel {
    
    override func awakeFromNib() {
        
        self.layer.shadowOpacity = 1.5
        self.layer.shadowRadius = 1.5
        self.shadowColor = UIColor.black
        
    }
}
