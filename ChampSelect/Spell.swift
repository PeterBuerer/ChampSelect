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
    var sanitizedTooltip = ""
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
//            print("got raw effect array")
            effectWithNull.removeFirst() //remove null value that is always at the beginning
            
            if let effectWithoutNull = effectWithNull as? [[Double]] {
//                print("got effect")
                self.effect = effectWithoutNull
            }
        }
        
        if var effectBurn = dictionary["effectBurn"] as? [String] {
//            effectBurn.removeFirst() //remove empty string that is always at the beginning
            self.effectBurn = effectBurn
        }
        else {
            print("didn't get effectburn")
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
            //TODO: Parse resource
            
            
            self.resource = resource
        }
       
        if let vars = dictionary["vars"] as? [[String : AnyObject]] {
            for spellVar in vars {
                self.spellVars.append(SpellVars(dictionary: spellVar))
            }
        }
        
        if let sanitizedTooltip = dictionary["sanitizedTooltip"] as? String {
            //parse keys from tooltip
            let keysInTooltip = findKeysInTooltip(sanitizedTooltip)
            let newTooltip = newTooltipWithValues(keysInTooltip, tip: sanitizedTooltip)
            
            
            self.sanitizedTooltip = newTooltip
        }
        
        if let tooltip = dictionary["tooltip"] as? String {
            self.tooltip = tooltip
        }
    }
    
    init() {
        
    }
    
    
    //==========================================================================
    // MARK: - Parsing Variable Keys
    //==========================================================================
    
    func findKeysInTooltip(tip: String) -> [String] {
        var keys = [String]()
        do {
            let regex = try NSRegularExpression(pattern: "\\{\\{ ([a-z][0-9]) \\}\\}", options: .CaseInsensitive)
            let matches = regex.matchesInString(tip, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, tip.characters.count))
           
            for match in matches {
                let range = match.rangeAtIndex(1) //get the capture group that matched
                let result = NSString(string: tip).substringWithRange(range) //get actual string of the group
                keys.append(result)
            }
        }
        catch let error as NSError {
            print("Error parsing tooltip: \(error.localizedDescription)")
        }
        
       return keys
    }
    
    func findKeysInResource(resource: String) -> [String] {
        var keys = [String]()
        
        
        return keys
    }
    
    //==========================================================================
    // MARK: - Getting Associated Variable Values
    //==========================================================================

    func newTooltipWithValues(keys: [String], tip: String) -> String {
        var newTooltip = tip
       
        
        for key in keys {
            if key.characters.count > 0 {
                if key[key.startIndex] == "e" {
                    //effect
                    if let index = Int(String(key[key.startIndex.advancedBy(1)])), range = newTooltip.rangeOfString("{{ \(key) }}") where effectBurn.count > 0 { //get index number from string
                        //fill in values
                        newTooltip.replaceRange(range, with: effectBurn[index])
                        
                        //TODO: figure out what to put for champs like Lux who don't seem to have an effectBurn array
                    }
                }
                else if key[key.startIndex] == "a" || key[key.startIndex] == "f" {
                    //check spell vars
                    
                    if let spellVarsOneIndexed = Int(String(key.characters.dropFirst())) {
                        let spellVarsIndex = spellVarsOneIndexed - 1 //replace gross one indexed number with a zero indexed number
                        
                        if spellVars.count > spellVarsIndex {
                            
                            let spellVar = spellVars[spellVarsIndex]
                            
                            if spellVar.key == key {
                                if let range = newTooltip.rangeOfString("{{ \(key) }}") where spellVar.coefficient.count > 0 {
                                    var replacementString = "\(spellVar.coefficient[0]) \(spellVar.link)"
                                    
                                    if spellVar.coefficient.count > 1 {
                                        //make a combined string of all the different values for the variable at its different levels
                                        replacementString = ""
                                        for coeff in spellVar.coefficient {
                                            replacementString += "\(coeff)/"
                                        }
                                        
                                        replacementString.removeAtIndex(replacementString.endIndex.predecessor()) //remove extra "/"
                                    }
                                    
                                    newTooltip.replaceRange(range, with: replacementString)
                                    //TODO: make an enum on SpellVars or something to return AP, AD etc for the given link
                                }
                                else {
                                    print("Couldn't replace key with value for: \(key) in \(self.name)")
                                }
                            }   
                        }
                    }
                }
                else {
                    print("Got an unknown key")
                }
                
            }
        }
        
        return newTooltip
    }
}