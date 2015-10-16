//
//  Stats.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/10/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

class Stats {
   
    var armor = 0.0
    var armorPerLevel = 0.0
    var attackDamage = 0.0
    var attackDamagePerLevel = 0.0
    var attackRange = 0.0
    var attackSpeedOffset = 0.0
    var attackSpeedPerLevel = 0.0
    var crit = 0.0
    var critPerLevel = 0.0
    var hp = 0.0
    var hpPerLevel = 0.0
    var hpRegen = 0.0
    var hpRegenPerLevel = 0.0
    var moveSpeed = 0.0
    var mp = 0.0
    var mpPerLevel = 0.0
    var mpRegen = 0.0
    var mpRegenPerLevel = 0.0
    var spellBlock = 0.0
    var spellBlockPerLevel = 0.0
    
    init(dictionary: [String : Double]) {
        if let armor = dictionary["armor"] {
           self.armor = armor
        }
        
        if let armorPerLevel = dictionary["armorperlevel"] {
            self.armorPerLevel = armorPerLevel
        }
        
        if let attackDamage = dictionary["attackdamage"] {
            self.attackDamage = attackDamage
        }
        
        if let attackDamagePerLevel = dictionary["attackdamageperlevel"] {
            self.attackDamage = attackDamagePerLevel
        }
        
        if let attackRange = dictionary["attackrange"] {
            self.attackRange = attackRange
        }
        
        if let attackSpeedOffset = dictionary["attackspeedoffset"] {
            self.attackSpeedOffset = attackSpeedOffset
        }
        
        if let attackSpeedPerLevel = dictionary["attackSpeedPerLevel"] {
            self.attackSpeedPerLevel = attackSpeedPerLevel
        }
        
        if let crit = dictionary["crit"] {
            self.crit = crit
        }
        
        if let critPerLevel = dictionary["critperlevel"] {
            self.critPerLevel = critPerLevel
        }
        
        if let hp = dictionary["hp"] {
            self.hp = hp
        }
        
        if let hpPerLevel = dictionary["hpperlevel"] {
            self.hpPerLevel = hpPerLevel
        }
        
        if let hpRegen = dictionary["hpRegen"] {
            self.hpRegen = hpRegen
        }
        
        if let hpRegenPerLevel = dictionary["hpregenperlevel"] {
            self.hpRegenPerLevel = hpRegenPerLevel
        }
        
        if let moveSpeed = dictionary["movespeed"] {
            self.moveSpeed = moveSpeed
        }
        
        if let mp = dictionary["mp"] {
            self.mp = mp
        }
        
        if let mpPerLevel = dictionary["mpperlevel"] {
            self.mpPerLevel = mpPerLevel
        }
        
        if let mpRegen = dictionary["mpregen"] {
            self.mpRegen = mpRegen
        }
        
        if let mpRegenPerLevel = dictionary["mpregenperlevel"] {
            self.mpRegenPerLevel = mpRegenPerLevel
        }
        
        if let spellBlock = dictionary["spellblock"] {
            self.spellBlock = spellBlock
        }
        
        if let spellBlockPerLevel = dictionary["spellblockperlevel"] {
            self.spellBlockPerLevel = spellBlockPerLevel
        }
    }
    
    init() {
        
    }
}