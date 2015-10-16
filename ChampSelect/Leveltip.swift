//
//  LevelTip.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/10/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

class Leveltip {
    
    var effect = [String]()
    var label = [String]()
    
    init(dictionary: [String : AnyObject]) {
        if let effect = dictionary["effect"] as? [String] {
            self.effect = effect
        }
        
        if let label = dictionary["label"] as? [String] {
            self.label = label
        }
    }
    
    init() {
        
    }
}