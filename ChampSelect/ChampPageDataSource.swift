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
        titleModel.items.append(ChampItemViewModel(title: champ.title, info: ""))
        
        if champ.skins.count > 0 {
            if let image = champ.skins[0].image {
                titleModel.items[0].image = image
            }
        }
        
        let description = champ.blurb
        let descriptionModel = ChampSectionViewModel()
        descriptionModel.title = "Description: "
        descriptionModel.items.append(ChampItemViewModel(title: "", info: description))
        
        
        sections.append(titleModel)
        sections.append(descriptionModel)
    }
}



