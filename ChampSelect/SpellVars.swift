//
//  SpellVars.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/10/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

class SpellVars {
   
    var coefficient = [Double]()
    var dyn = "" //dynamic?
    var key = ""
    var link = ""
    var ranksWith = ""
    
    init(dictionary: [String : AnyObject]) {
        if let coefficient = dictionary["coeff"] as? [Double] {
            self.coefficient = coefficient
        }
        
        if let dyn = dictionary["dyn"] as? String { //dynamic?
           self.dyn = dyn
        }
        
        if let key = dictionary["key"] as? String {
            self.key = key
        }
        
        if let link = dictionary["link"] as? String {
            self.link = link
        }
        
        if let ranksWith = dictionary["ranksWith"] as? String {
            self.ranksWith = ranksWith
        }
    }
    
    init() {
        
    }
}