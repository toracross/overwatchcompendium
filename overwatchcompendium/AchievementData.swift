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
    
    private var _achName: String!
    private var _achDescription: String!
    private var _achFinished: Bool!
    
    var achName: String {
        if _achName == nil {
            _achName = ""
        }
        return _achName
    }
    
    var achDescription: String {
        if _achDescription == nil {
            _achDescription = ""
        }
        return _achDescription
    }
    
    var achFinished: Bool {
        if _achFinished == nil {
            _achFinished = false
        }
        return _achFinished
    }
    
    //Achievement Parsing
    
    
    
    
}
