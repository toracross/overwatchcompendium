//
//  Achievements.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/11/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

// Achievement icons provided by http://overwatch.wikia.com/wiki/Achievements

import UIKit
import Alamofire

class AchievementData {
    
    private var _achievementTitle: String!
    
    var achievementTitle: String {
        get {
            if _achievementTitle == nil {
                _achievementTitle = ""
            }
            return _achievementTitle
        }
    }
    
    
}
