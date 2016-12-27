//
//  PlayerHeroesCP.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/24/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit
import Alamofire

class PlayerHeroesCP {
    
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
    
    init(heroCPDict: [Dictionary<String, AnyObject>]) {
        
        if let image = heroCPDict[0]["image"] as? String {
            self._image = image
            print(image)
        }
        
        if let name = heroCPDict[0]["name"] as? String {
            self._name = name
            print(name)
        }
        
        if let percentage = heroCPDict[0]["percentage"] as? Float {
            self._percentage = percentage
            print(percentage)
        }
        
        if let playtime = heroCPDict[0]["playtime"] as? String {
            self._playtime = playtime
            print(playtime)
        }
        
    }
}
