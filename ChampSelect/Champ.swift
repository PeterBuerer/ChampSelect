//
//  Champ.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/6/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import UIKit

class Champ {
    var name = ""
    var idNumber = 0
    
    var imageName: String = ""
    var iconImage: UIImage?
    
    var skins = [Skin]()
    
    var blurb = ""

    var allyTips = [String]()
    var enemyTips = [String]()
    
    var basicInfo = BasicInfo(dictionary: [:])
    var key = ""
    var lore = ""
    
    var parType = "" //things used with abilities ... sorta mana, energy, wind, battelfury, none etc... don't know if going to use this one
    var passive = Passive(dictionary: [:])
    
    var spells = [Spell]()
    var stats = Stats(dictionary: [:])
    var tags = [String]()
    var title = ""
//    Name	Data Type	Description
//    recommended	List[RecommendedDto] //probably won't include this
    
    
    init(dictionary: [String : AnyObject]) {
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        
        if let id = dictionary["id"] as? Int {
            self.idNumber = id
        }
        
        print("Name: \(self.name) ID: \(self.idNumber)")
        
        if let imageJSON = dictionary["image"], imageName = imageJSON["full"] as? String {
            self.imageName = imageName
        }
        
        if let key = dictionary["key"] as? String {
            self.key = key
        }
        
        if let skinsJSON = dictionary["skins"] as? [[String : AnyObject]] {
            for skin in skinsJSON {
                if let id = skin["id"] as? Int, name = skin["name"] as? String, number = skin["num"] as? Int {
                    let newSkin = Skin(id: id, name: name, number: number)
                    self.skins.append(newSkin)
                }
            }
            
            self.skins.sortInPlace { (left, right) -> Bool in
                return left.number < right.number
            }
        }
        
        if let blurb = dictionary["blurb"] as? String {
            self.blurb = blurb
        }
        
        if let allyTips = dictionary["allytips"] as? [String] {
            self.allyTips = allyTips
        }
        
        if let enemyTips = dictionary["enemytips"] as? [String] {
            self.enemyTips = enemyTips
        }
        
        if let basicInfoDictionary = dictionary["info"] as? [String : Int] {
            let basicInfo = BasicInfo(dictionary: basicInfoDictionary)
            self.basicInfo = basicInfo
        }
        
        if let lore = dictionary["lore"] as? String {
            self.lore = lore
        }
        
        if let parType = dictionary["partype"] as? String {
            self.parType = parType
        }
        
        if let passiveDictionary = dictionary["passive"] as? [String : String] {
            let passive = Passive(dictionary: passiveDictionary)
            self.passive = passive
        }
        
        if let spellsArrayDictionary = dictionary["spells"] as? [[String : AnyObject]] {
            //TODO: initialize spells
            var spells = [Spell]()
            for spellDict in spellsArrayDictionary {
                let spell = Spell(dictionary: spellDict)
                spells.append(spell)
            }
            
            self.spells = spells
        }
        
        if let statsDictionary = dictionary["stats"] as? [String : Double] {
            //TODO: initialize stats
            let stats = Stats(dictionary: statsDictionary)
            self.stats = stats
        }
        
        if let tags = dictionary["tags"] as? [String] {
            self.tags = tags
        }
    }
    
    init() {
        
    }
}