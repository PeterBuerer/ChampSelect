//
//  ChampList.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/6/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

typealias ChampManagerChampListCompletion = ([Champ]) -> ()

class ChampManager {
    
//    var champs = [Champ]()
    
    static let defaultChampManager = ChampManager()
    
    func updateChamps(completion: ChampManagerChampListCompletion) {
        NetworkManager.defaultNetworkManager.champListRequest() { [weak self] (champList: [String : AnyObject]) in
            guard let strongSelf = self else { return }
            
            let newChamps = strongSelf.champsFromJSON(champList)
//                strongSelf.champs = newChamps
            completion(newChamps)
        }
    }
    
    func champsFromJSON(json: [String : AnyObject]) -> [Champ] {
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
       
        champs.sortInPlace { (left, right) -> Bool in
            return left.name < right.name
        }
        
        return champs
    }
    
    
}