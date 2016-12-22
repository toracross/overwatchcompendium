//
//  UIImageRounded.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/21/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class UIImageRounded: UIImageView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
    }
    
}
