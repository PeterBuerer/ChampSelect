//
//  ChampList.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/6/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

class ChampManager {
    static func champsFromJSON(json: [String : AnyObject]) -> [Champ] {
        var champs = [Champ]()
        for value in json.values {
            if let champDictionary = value as? [String: AnyObject] {
                let champ = Champ()
                if let name = champDictionary["name"] as? String {
                    champ.name = name
                }
           
                if let id = champDictionary["id"] as? Int{
                        champ.idNumber = id
                }
                
                champs.append(champ)
            }
        }
        
        return champs
    }
    
    
}