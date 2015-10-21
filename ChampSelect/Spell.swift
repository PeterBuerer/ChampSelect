//
//  Spell.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/10/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

class Spell {
    var name = ""
    var description = ""
    var sanitizedDescription = ""
    var cooldown = [Double]()
    var cooldownBurn = ""
    var costBurn = ""
    var costType = ""
    var effect = [[Double]]()
    var effectBurn = [String]() //might need to convert this to a number??
    var key = ""
    var levelTip = Leveltip()
    var maxRank = 0
    var range = [Int]() //This field is either a List of Integer or the String 'self' for spells that target one's own champion.
    var targetsSelf = false
    var rangeBurn = ""
    var resource = ""
    var sanitizedToolTip = ""
    var tooltip = ""
    var spellVars = [SpellVars]()
    
//    
//    Name	Data Type	Description
//    altimages	List[ImageDto] //maybe do this later
//    effect	List[object]	This field is a List of List of Double.
    
//    image	ImageDto
    
    init(dictionary: [String : AnyObject]) {
        //TODO: implement this
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let description = dictionary["description"] as? String {
            self.description = description
        }
        
        if let sanitizedDescription = dictionary["sanitizedDescription"] as? String {
            //TODO: check key for this
            self.sanitizedDescription = sanitizedDescription
        }
        
        if let cooldown = dictionary["cooldown"] as? [Double] {
            self.cooldown = cooldown
        }
        
        if let cooldownBurn = dictionary["cooldownBurn"] as? String {
            self.cooldownBurn = cooldownBurn
        }
    
        if let costBurn = dictionary["costBurn"] as? String {
            self.costBurn = costBurn
        }
        
        if let costType = dictionary["costType"] as? String {
            self.costType = costType
        }
        
        if var effectWithNull = dictionary["effect"] as? [AnyObject] {
            print("got raw effect array")
            
            effectWithNull.removeFirst()
            
            if let effectWithoutNull = effectWithNull as? [[Double]] {
                print("got effect")
                self.effect = effectWithoutNull
            }
        }
        
        if let effectBurn = dictionary["effectBurn"] as? [String] {
           self.effectBurn = effectBurn
        }
        
        if let key = dictionary["key"] as? String {
           self.key = key
        }
        
        if let levelTip = dictionary["leveltip"] as? [String : String] {
            self.levelTip = Leveltip(dictionary: levelTip)
        }
       
        if let maxRank = dictionary["maxrank"] as? Int {
            self.maxRank = maxRank
        }
        
        if let rangeInt = dictionary["range"] as? [Int] { //This field is either a List of Integer or the String 'self' for spells that target one's own champion.
            self.range = rangeInt
        }
        else if let _ = dictionary["range"] as? String {
            self.targetsSelf = true
        }
        
        if let rangeBurn = dictionary["rangeBurn"] as? String {
            self.rangeBurn = rangeBurn
        }
        
        if let resource = dictionary["resource"] as? String {
            self.resource = resource
        }
        
        if let sanitizedToolTip = dictionary["sanitizedTooltip"] as? String {
            self.sanitizedToolTip = sanitizedToolTip
        }
        
        if let tooltip = dictionary["tooltip"] as? String {
            self.tooltip = tooltip
        }
        
        if let vars = dictionary["vars"] as? [[String : AnyObject]] {
            for spellVar in vars {
                self.spellVars.append(SpellVars(dictionary: spellVar))
            }
        }
    }
    
    init() {
        
    }
}