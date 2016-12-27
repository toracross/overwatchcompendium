//
//  PlayerHeroesQP.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/24/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire

class PlayerHeroesQP {
    
    private var _image: String!
    private var _name: String!
    private var _percentage: Float!
    private var _playtime: String!
    
    var image: String {
        if _image == nil {
            _image = ""
        }
        return _image
    }
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var percentage: Float {
        if _percentage == nil {
            _percentage = 0
        }
        return _percentage
    }
    
    var playtime: String {
        if _playtime == nil {
            _playtime = "0 Hours"
        }
        return _playtime
    }
    
    init(heroQPDict: [Dictionary<String, AnyObject>]) {
        
        if let unfixedImg = heroQPDict[0]["image"] as? String {
            let image = unfixedImg.substring(from: unfixedImg.index(unfixedImg.endIndex, offsetBy: -22))
            self._image = image
        }
        
        if let unfixedName = heroQPDict[0]["name"] as? String {
            let secondName = unfixedName.replacingOccurrences(of: "Torbj&#xF6;rn", with: "Torbjörn")
            let name = secondName.replacingOccurrences(of: "L&#xFA;cio", with: "Lúcio")
            self._name = name
        }
                
        if let percentage = heroQPDict[0]["percentage"] as? Float {
            self._percentage = percentage
            print(percentage)
        }
        
        if let playtime = heroQPDict[0]["playtime"] as? String {
            self._playtime = playtime
        }
        
    }
}
