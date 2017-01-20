//
//  CustomLblTitle.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/19/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.
//

import UIKit

class CustomLblTitle: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowOpacity = 1.5
        self.layer.shadowRadius = 1.5
        self.shadowColor = UIColor.black
    }
}
