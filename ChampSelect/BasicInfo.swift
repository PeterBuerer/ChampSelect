//
//  BasicInfo.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/11/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

class BasicInfo { //InfoDto
    var attack = 0
    var defense = 0
    var difficulty = 0
    var magic = 0
    
    init(dictionary: [String : Int]) {
        if let attack = dictionary["attack"] {
            self.attack = attack
        }
        
        if let defense = dictionary["defense"] {
            self.defense = defense
        }
        
        if let difficulty = dictionary["difficulty"] {
            self.difficulty = difficulty
        }
        
        if let magic = dictionary["magic"] {
            self.magic = magic
        }
    }
}