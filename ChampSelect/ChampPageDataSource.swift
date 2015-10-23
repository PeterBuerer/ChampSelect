//
//  ChampPageDataModel.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/20/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

class ChampPageDataSource {
    var sections = [ChampSectionViewModel]()
    
    init(champ: Champ) {
        
        let titleModel = ChampSectionViewModel()
        titleModel.items.append(ChampItemViewModel(title: champ.title, info: "", size: .Large))
        
        if champ.skins.count > 0 {
            if let image = champ.skins[0].image {
                titleModel.items[0].image = image
            }
        }
        
        let descriptionModel = ChampSectionViewModel()
        descriptionModel.title = "Description"
        descriptionModel.items.append(ChampItemViewModel(title: "", info: champ.blurb, size: .Medium))
        
       
        let basicInfoModel = ChampSectionViewModel()
        basicInfoModel.title = "Basic Info"
        
        let attack = champ.basicInfo.attack
        let defense = champ.basicInfo.defense
        let magic = champ.basicInfo.magic
        let difficulty = champ.basicInfo.difficulty
            
        basicInfoModel.items.append(ChampItemViewModel(title: "Attack: ", info: "\(attack)", size: .Small))
        basicInfoModel.items.append(ChampItemViewModel(title: "Defense: ", info: "\(defense)", size: .Small))
        basicInfoModel.items.append(ChampItemViewModel(title: "Magic: ", info: "\(magic)", size: .Small))
        basicInfoModel.items.append(ChampItemViewModel(title: "Difficulty: ", info: "\(difficulty)", size: .Small))
        
       
        let passiveModel = ChampSectionViewModel()
        passiveModel.title = "Passive"
        passiveModel.items.append(ChampItemViewModel(title: champ.passive.name, info: champ.passive.sanitizedDescription, size: .Medium))
        
        let abilityModel = ChampSectionViewModel()
        abilityModel.title = "Abilities"
        
        for ability in champ.spells {
            abilityModel.items.append(ChampItemViewModel(title: ability.name, info: ability.sanitizedTooltip, size: .Medium))
        }
       
        
        sections.append(titleModel)
        sections.append(descriptionModel)
        sections.append(basicInfoModel)
        sections.append(passiveModel)
        sections.append(abilityModel)
    }
}



