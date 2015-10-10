//
//  NetworkManager.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/9/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Alamofire

typealias NetworkManagerChampListCompletion = ([String : AnyObject]) -> ()
typealias NetworkManagerChampInfoCompletion = ([String : AnyObject]) -> ()

class NetworkManager {

    //==========================================================================
    // MARK: - Singleton
    //==========================================================================
    
    static let defaultNetworkManager = NetworkManager()
    
    func champListRequest(completion: NetworkManagerChampListCompletion) {
        //get champs
        //pass into completion
        Alamofire.request(.GET, "https://na.api.pvp.net/api/lol/static-data/na/v1.2/champion/", parameters: ["api_key" : "0836a23b-2084-4ad1-bbcf-a9fca10efeae", "champData": "all"])
            .responseJSON { response in
                //print("Data \(response.data) \n")     // server data
                print("Result \(response.result) \n")   // result of response serialization
                
                if let JSON = response.result.value as? [String : AnyObject], data = JSON["data"] as? [String : AnyObject] {
                    print("JSON: \(JSON) \n")
                   
                    completion(data)
                }
        }
    }
    
    func getCDN() {
        Alamofire.request(.GET, "https://global.api.pvp.net/api/lol/static-data/na/v1.2/realm", parameters: ["api_key" : "0836a23b-2084-4ad1-bbcf-a9fca10efeae"])
            .responseJSON { response in
                //print("Request \(response.request) \n")  // original URL request
                //print("Response \(response.response) \n") // URL response
                //print("Data \(response.data) \n")     // server data
                print("Result \(response.result) \n")   // result of response serialization
                
                if let JSON = response.result.value as? [String : AnyObject] {
                    print("JSON: \(JSON) \n")
                }
        }
    }
    
    func champInfoRequest(completion:NetworkManagerChampInfoCompletion) {
        //get champ info
        //pass into completion
    }
}