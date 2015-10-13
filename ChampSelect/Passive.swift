//
//  Passive.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/10/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

class Passive {
   
    var description = ""
    var name = ""
    var sanitizedDescription = ""
    
    init(dictionary: [String : AnyObject]) {
        if let description = dictionary["description"] as? String {
            self.description = description
        }
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let sanitizedDescription = dictionary["sanitizedDescription"] as? String {
            self.sanitizedDescription = sanitizedDescription
        }
    }
//    image	ImageDto                    //TODO: might need to include this
}
