//
//  ChampItemViewModel.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/19/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

class ChampItemViewModel {
    var title = ""
    var info = ""
    var image: UIImage?
    
    init(title: String, info: String) {
        self.title = title
        self.info = info
    }
}