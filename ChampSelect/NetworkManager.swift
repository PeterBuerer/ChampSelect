//
//  NetworkManager.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/9/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import Alamofire
import Foundation

typealias NetworkManagerChampListCompletion = ([String : AnyObject]?) -> ()
typealias NetworkManagerChampInfoCompletion = ([String : AnyObject]?) -> ()
typealias NetworkManagerCDNCompletion = (String?) -> ()
typealias NetworkManagerChampImageCompletion = (UIImage?) -> ()

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
    
    func fullChampListRequest(completion: NetworkManagerChampListCompletion) {
        Alamofire.request(.GET, "https://na.api.pvp.net/api/lol/static-data/na/v1.2/champion/", parameters: ["api_key" : APIKey, "champData": "all"])
            .responseJSON { response in
                //print("Data \(response.data) \n")     // server data
                print("Result \(response.result) \n")   // result of response serialization
                
                guard let json = response.result.value as? [String : AnyObject], data = json["data"] as? [String : AnyObject] else {
                    completion(nil)
                    return
                }
                
//                print("JSON: \(json) \n")
                completion(data)
        }
    }
    
    func cdnRequest(completion: NetworkManagerCDNCompletion) {
        Alamofire.request(.GET, "https://global.api.pvp.net/api/lol/static-data/na/v1.2/realm", parameters: ["api_key" : APIKey])
            .responseJSON { response in
                print("Request \(response.request) \n")  // original URL request
                print("Response \(response.response) \n") // URL response
                print("Data \(response.data) \n")     // server data
                print("Result \(response.result) \n")   // result of response serialization
                
                guard let json = response.result.value as? [String : AnyObject], cdn = json["cdn"] as? String else {
                    completion(nil)
                    return
                }
                
                completion(cdn)
                print("JSON: \(json) \n")
        }
    }
    
    func champImageRequest(imageName: NSString, imageType: ChampImageType, skinNumber: Int, completion: NetworkManagerChampImageCompletion) {
       
        let fileExtension = imageType.imageExtensionForType() //TODO: remove this if not needed
      
        var url: NSURL?
      
        //TODO: replace hardcoded CDN version with version pull from realm
        switch imageType {
        case .Square:
            url = NSURL(string: "http://ddragon.leagueoflegends.com/cdn/5.19.1/img/champion/\(imageName)?api_key=\(APIKey)")
        default:
            //create skin url string
            let imageNameNSString = NSString(string: imageName)
            let baseImageName = String(imageNameNSString.stringByDeletingPathExtension)
            url = NSURL(string: "http://ddragon.leagueoflegends.com/cdn/img/champion/\(imageType)/\(baseImageName)_\(skinNumber)\(fileExtension)?api_key=\(APIKey)")
        }
       
        guard let completeURL = url else {
            completion(nil)
            return
        }
        
        let requestOperation = AFHTTPRequestOperation(request: NSURLRequest(URL: completeURL))
            requestOperation.responseSerializer = AFImageResponseSerializer()
        
            requestOperation.setCompletionBlockWithSuccess({ (operation, responseObject) -> Void in
                guard let image = responseObject as? UIImage else {
                    print("got something that wasn't an image")
                    completion(nil)
                    return
                }
                
                print("got image")
                completion(image)
                
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
}