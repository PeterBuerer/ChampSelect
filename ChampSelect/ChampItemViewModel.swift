//
//  ChampItemViewModel.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/19/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

enum ItemSize {
    case Small
    case Medium
    case Large
}

class ChampItemViewModel {
    var title = ""
    var info = ""
    var image: UIImage?
    var size = ItemSize.Small
    
    init(title: String, info: String, size: ItemSize) {
        self.title = title
        self.info = info
        self.size = size
    }
}