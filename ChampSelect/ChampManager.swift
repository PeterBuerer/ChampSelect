//
//  ChampList.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/6/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Foundation

typealias ChampManagerChampListCompletion = ([Champ]) -> ()
typealias ChampManagerImageCompletion = (UIImage?) -> ()

class ChampManager {
    
//    var champs = [Champ]() //TODO: use this or get rid of it
   
    //==========================================================================
    // MARK: - Singleton 
    //==========================================================================

    static let defaultChampManager = ChampManager()
    
    //grabs info for all champs
    func updateChampInfo(completion: ChampManagerChampListCompletion) {
        NetworkManager.defaultNetworkManager.fullChampListRequest() { [weak self] (champList: [String : AnyObject]?) in
            guard let champList = champList, strongSelf = self else {
                print("Error getting champ list")
                return
            }
            
            let newChamps = strongSelf.champsFromJSON(champList)
//                strongSelf.champs = newChamps
            completion(newChamps)
        }
    }
   
    //==========================================================================
    // MARK: - JSON Parsing
    //==========================================================================

    func champsFromJSON(json: [String : AnyObject]) -> [Champ] {
        var champs = [Champ]()
        for value in json.values {
            if let champDictionary = value as? [String: AnyObject] {
                let champ = Champ(dictionary: champDictionary)
                champs.append(champ)
            }
        }
       
        champs.sortInPlace { (left, right) -> Bool in
            return left.name < right.name
        }
        
        return champs
    }
   
    func champIconImage(champ: Champ, completion: ChampManagerImageCompletion) {
        NetworkManager.defaultNetworkManager.champImageRequest(champ.imageName, champKey: champ.key, imageType: .Square, skinNumber: 0) { (image) -> () in
            completion(image)
        }
    }
   
    func champLoadingScreenImage(champ: Champ, skinNumber: Int, completion: ChampManagerImageCompletion) {
        NetworkManager.defaultNetworkManager.champImageRequest(champ.imageName, champKey: champ.key, imageType: .Loading, skinNumber: skinNumber) { (champImage) -> () in
            completion(champImage)
        }
    }
}