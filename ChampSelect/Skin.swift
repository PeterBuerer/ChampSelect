//
//  Skin.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/10/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

class Skin {
    var id = 0
    var name = "default"
    var number = 0
    var image: UIImage? //TODO: use this for champ images
    
    init(id: Int, name: String, number: Int) {
        self.id = id
        self.name = name
        self.number = number
    }
}