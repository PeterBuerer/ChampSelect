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
}