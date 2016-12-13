//
//  CustomTxtField.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/11/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override func awakeFromNib() {
        
        self.layer.shadowOpacity = 1.5
        self.layer.shadowRadius = 1.5
        self.layer.cornerRadius = 3
        
    }
}
