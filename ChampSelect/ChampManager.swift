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
                let champ = champFromDictionary(champDictionary)
                champs.append(champ)
            }
        }
       
        champs.sortInPlace { (left, right) -> Bool in
            return left.name < right.name
        }
        
        return champs
    }
   
    //TODO: There must be a better way...
    func champFromDictionary(champDictionary: [String : AnyObject]) -> Champ {
        let champ = Champ()
        if let name = champDictionary["name"] as? String {
            champ.name = name
        }
        
        if let title = champDictionary["title"] as? String {
            champ.title = title
        }
        
        if let id = champDictionary["id"] as? Int {
            champ.idNumber = id
        }
        
        print("Name: \(champ.name) ID: \(champ.idNumber)")
        
        if let imageJSON = champDictionary["image"], imageName = imageJSON["full"] as? String {
            champ.imageName = imageName
        }
        
        if let key = champDictionary["key"] as? String {
            champ.key = key
        }
        
        if let skinsJSON = champDictionary["skins"] as? [[String : AnyObject]] {
            for skin in skinsJSON {
                if let id = skin["id"] as? Int, name = skin["name"] as? String, number = skin["num"] as? Int {
                    let newSkin = Skin(id: id, name: name, number: number)
                    champ.skins.append(newSkin)
                }
            }
            
            champ.skins.sortInPlace { (left, right) -> Bool in
                return left.number < right.number
            }
        }
       
        if let blurb = champDictionary["blurb"] as? String {
            champ.blurb = blurb
        }
        
        if let allyTips = champDictionary["allytips"] as? [String] {
            champ.allyTips = allyTips
        }
        
        if let enemyTips = champDictionary["enemytips"] as? [String] {
            champ.enemyTips = enemyTips
        }
        
        if let basicInfoDictionary = champDictionary["info"] as? [String : Int] {
            let basicInfo = BasicInfo(dictionary: basicInfoDictionary)
            champ.basicInfo = basicInfo
        }
        
        if let lore = champDictionary["lore"] as? String {
            champ.lore = lore
        }
        
        if let parType = champDictionary["partype"] as? String {
            champ.parType = parType
        }
        
        if let passiveDictionary = champDictionary["passive"] as? [String : AnyObject] {
            let passive = Passive(dictionary: passiveDictionary)
            champ.passive = passive
        }
        
        if let spellsArrayDictionary = champDictionary["spells"] as? [[String : AnyObject]] {
            //TODO: initialize spells
            var spells = [Spell]()
            for spellDict in spellsArrayDictionary {
                let spell = Spell(dictionary: spellDict)
                spells.append(spell)
            }
            
            champ.spells = spells
        }
        
        if let statsDictionary = champDictionary["stats"] as? [String : Double] {
            //TODO: initialize stats
            let stats = Stats(dictionary: statsDictionary)
            champ.stats = stats
        }
        
        if let tags = champDictionary["tags"] as? [String] {
            champ.tags = tags
        }
       
        return champ
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