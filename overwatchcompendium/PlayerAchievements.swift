//
//  PlayerAchievements.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/11/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//


import UIKit

class PlayerAchievements {
    
    private var _totalAchievements: String!
    private var _achName: String!
    private var _achFinished: Bool!
    private var _achImage: String!
    private var _achDescription: String!
    
    var totalAchievements: String {
        if _totalAchievements == nil {
            _totalAchievements = ""
        }
        return _totalAchievements
    }
    
    var achName: String {
        if _achName == nil {
            _achName = ""
        }
        return _achName
    }
    
    var achFinished: Bool {
        if _achFinished == nil {
            _achFinished = false
        }
        return _achFinished
    }
    
    var achImage: String {
        if _achImage == nil {
            _achImage = ""
        }
        return _achImage
    }
    
    
    var achDescription: String {
        if _achDescription == nil {
            _achDescription = ""
        }
        return _achDescription
    }
    

    //Achievement Parsing
    
    init(heroAchDict: [Dictionary<String, AnyObject>]) {
        
        if let achName = heroAchDict[0]["name"] as? String {
            let fixedAchName = achName.replacingOccurrences(of: "&apos;", with: "'")
            self._achName = fixedAchName
            print(achName)
        }
        
        if let achFinished = heroAchDict[0]["finished"] as? Bool {
            self._achFinished = achFinished
        }
        
        if let achImage = heroAchDict[0]["image"] as? String {
            self._achImage = achImage
        }
        
        if let achDescription = heroAchDict[0]["description"] as? String {
            let firstAchDescription = achDescription.replacingOccurrences(of: "&apos;", with: "'")
            let secondAchDescription = firstAchDescription.replacingOccurrences(of: "&#xFA;", with: "ú")
            let thirdAchDescription = secondAchDescription.replacingOccurrences(of: "&#xF6;", with: "ö")
            self._achDescription = thirdAchDescription
            print(achDescription)
        }
        
    }
    
    
    
}
