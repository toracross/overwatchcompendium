//
//  RoundedCorner.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 1/19/17.
//  Copyright © 2017 Wellison Pereira. All rights reserved.
//

import UIKit

class RoundedCorner: UIButton {
    override func awakeFromNib() {
     
        self.layer.cornerRadius = 5
        self.layer.shadowOpacity = 2
    }
}
