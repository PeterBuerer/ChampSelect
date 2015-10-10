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
    
    func champsFromJSON(json: [String : AnyObject]) -> [Champ] {
        var champs = [Champ]()
        for value in json.values {
            if let champDictionary = value as? [String: AnyObject] {
                let champ = Champ()
                if let name = champDictionary["name"] as? String {
                    champ.name = name
                }
           
                if let id = champDictionary["id"] as? Int {
                    champ.idNumber = id
                }
                
                if let imageJSON = champDictionary["image"], imageName = imageJSON["full"] as? String {
                    champ.imageName = imageName
                }
                
                if let skinsJSON = champDictionary["skins"] as? [String : AnyObject] {
                    for skin in skinsJSON.values {
                        if let id = skin["id"] as? Int, name = skin["name"] as? String, number = skin["num"] as? Int {
                            let newSkin = Skin(id: id, name: name, number: number)
                            champ.skins[name] = newSkin
                        }
                    }
                }
                
                champs.append(champ)
            }
        }
       
        champs.sortInPlace { (left, right) -> Bool in
            return left.name < right.name
        }
        
        return champs
    }
    
    func champDefaultImage(imageName: String, completion: ChampManagerImageCompletion) {
        NetworkManager.defaultNetworkManager.champImageRequest(imageName, imageType: ChampImageType.Square, skinNumber: 0) { (image) -> () in
            guard let image = image else {
                completion(nil)
                return
            }
            
            completion(image)
        }
    }
    
    
}