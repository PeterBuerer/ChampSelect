//
//  NetworkManager.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/9/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Alamofire
import Foundation

typealias NetworkManagerChampListCompletion = (listDataDictionary: [String : AnyObject]?) -> ()
typealias NetworkManagerChampInfoCompletion = (champInfoDictionary: [String : AnyObject]?) -> ()
typealias NetworkManagerCDNCompletion = (cdnURL: String?, cdnVersion: String?) -> ()
typealias NetworkManagerChampImageCompletion = (champImage: UIImage?) -> ()

let APIKey = "0836a23b-2084-4ad1-bbcf-a9fca10efeae"

enum ChampImageType: String {
    case Loading = "loading"
    case Square = "square"
    case Splash = "spalsh"
    
    func imageExtensionForType() -> String {
        switch self {
            case .Loading:
                 return ".jpg"
             case .Square:
                 return ".png"
             case .Splash:
                 return ".jpg"
        }
    }
}

class NetworkManager {

    //==========================================================================
    // MARK: - Singleton
    //==========================================================================
    
    static let defaultNetworkManager = NetworkManager()
    
    static var cdnURL = "http://ddragon.leagueoflegends.com/cdn"
    static var cdnVersion = "5.19.1"
    static var apiVersion = "v1.2" //TODO: check to see if api version is up to date
   
    
    //==========================================================================
    // MARK: - Champ Information Requests
    //==========================================================================

    func fullChampListRequest(completion: NetworkManagerChampListCompletion) {
        Alamofire.request(.GET, "https://na.api.pvp.net/api/lol/static-data/na/\(NetworkManager.apiVersion)/champion/", parameters: ["api_key" : APIKey, "champData": "all"])
            .responseJSON { response in
                //print("Data \(response.data) \n")     // server data
                print("Result \(response.result) \n")   // result of response serialization
                
                guard let json = response.result.value as? [String : AnyObject], data = json["data"] as? [String : AnyObject] else {
                    completion(listDataDictionary: nil)
                    return
                }
                
//                print("JSON: \(json) \n")
                completion(listDataDictionary: data)
        }
    }
    
    func champImageRequest(imageName: NSString, imageType: ChampImageType, skinNumber: Int, completion: NetworkManagerChampImageCompletion) {
       
        let fileExtension = imageType.imageExtensionForType() //TODO: remove this if not needed
      
        var url: NSURL?
      
        //TODO: replace hardcoded CDN + CDN version with version pulled from realm
        switch imageType {
            case .Square:
                 url = NSURL(string: "\(NetworkManager.cdnURL)/\(NetworkManager.cdnVersion)/img/champion/\(imageName)?api_key=\(APIKey)")
             default:
                 //create skin url string
                 let imageNameNSString = NSString(string: imageName)
                 let baseImageName = String(imageNameNSString.stringByDeletingPathExtension)
                 url = NSURL(string: "\(NetworkManager.cdnURL)/img/champion/\(imageType.rawValue)/\(baseImageName)_\(skinNumber)\(fileExtension)?api_key=\(APIKey)")
        }
       
        guard let completeURL = url else {
            completion(champImage: nil)
            return
        }
        
        let requestOperation = AFHTTPRequestOperation(request: NSURLRequest(URL: completeURL))
            requestOperation.responseSerializer = AFImageResponseSerializer()
        
            requestOperation.setCompletionBlockWithSuccess({ (operation, responseObject) -> Void in
                guard let image = responseObject as? UIImage else {
                    print("got something that wasn't an image")
                    completion(champImage: nil)
                    return
                }
                
                print("got image")
                completion(champImage: image)
                
            }, failure: { (operation, error) -> Void in
                print("Error: \(error.localizedDescription)")
            })
            
            requestOperation.start()
        
        return
    }
    
    func champInfoRequest(completion: NetworkManagerChampInfoCompletion) {
        //get champ info
        //pass into completion
        
    }
    
    
    //==========================================================================
    // MARK: - CDN Requests
    //==========================================================================
   
    //TODO: hook up notifications or something to trigger updates when a new cdn Version is pulled
    static func cdnRequest(completion: NetworkManagerCDNCompletion) {
        Alamofire.request(.GET, "https://global.api.pvp.net/api/lol/static-data/na/\(NetworkManager.apiVersion)/realm", parameters: ["api_key" : APIKey])
            .responseJSON { response in
                print("Request \(response.request) \n")  // original URL request
                print("Response \(response.response) \n") // URL response
                print("Data \(response.data) \n")     // server data
                print("Result \(response.result) \n")   // result of response serialization
                
                guard let json = response.result.value as? [String : AnyObject], newCDNURL = json["cdn"] as? String, newCDNVersion = json["v"] as? String else {
                    completion(cdnURL: nil, cdnVersion: nil)
                    return
                }
                
                completion(cdnURL: newCDNURL, cdnVersion: newCDNVersion)
                print("JSON: \(json) \n")
        }
    }
    
    static func updateCDN() {
        NetworkManager.cdnRequest { (newCDNURL, newCDNVersion) -> () in
            guard let cdnURL = newCDNURL, cdnVersion = newCDNVersion else { return }
            
            NetworkManager.cdnURL = cdnURL
            NetworkManager.cdnVersion = cdnVersion
        }
    }
    
}