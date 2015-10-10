//
//  ChampSelectCollectionViewController.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/6/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import UIKit
import Alamofire

class ChampSelectCollectionViewController: UICollectionViewController {
  
    var champs = [Champ]()
   
    let cellIdentifier = "cellidentifier"
    let collectionInset = CGFloat(16.0)
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(collectionViewLayout: layout)
        
        collectionView?.collectionViewLayout = flowlayout
        
        collectionView?.registerClass(ChampSelectCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.contentInset = UIEdgeInsets(top: collectionInset, left: collectionInset, bottom: collectionInset, right: collectionInset)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Storyboards will burn")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        updateChamps()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "Champ Select"
    }
   
    //==========================================================================
    // MARK: - UICollectionViewDataSource
    //==========================================================================

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champs.count
    }
   
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChampSelectCollectionViewCell

        let champ = champs[indexPath.item]
        
        cell.titleLabel.text = champ.name
        cell.imageView.image = champ.image
        
        return cell
    }
   
    //==========================================================================
    // MARK: - ChampDataSource
    //==========================================================================

    func updateChamps() {
        let completion = { [weak self] (champList: [Champ]) in
            guard let strongSelf = self else { return }
        
            strongSelf.champs = champList //ChampManager.champsFromJSON(data) //TODO: make right connections here
            
//            self?.getChampImages() //TODO: do this somehow
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                strongSelf.collectionView?.reloadData()
                strongSelf.updateAllChampImages()
            })
        }
        
        ChampManager.defaultChampManager.updateChampInfo(completion)
    }
    

    
    func updateAllChampImages() {
       
        for (index, champ) in champs.enumerate() {
            ChampManager.defaultChampManager.champDefaultImage(champ.imageName, completion: { [weak self] (image) -> () in
                guard let image = image, strongSelf = self else { return }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    strongSelf.champs[index].image = image
                    strongSelf.collectionView?.reloadItemsAtIndexPaths([NSIndexPath(forItem: index, inSection: 0)]) //TODO: find a way to make this not a hard coded number
                })
            })
            
            //TODO: replace cdn version dynamically
//            Alamofire.request(.GET, "http://ddragon.leagueoflegends.com/cdn/5.19.1/img/champion/\(champ.name).png", parameters:nil).responseData({ response in
//                
//                if let rawResponseImage = response.result.value, image = UIImage(data:rawResponseImage){
//                    let newImage = image
//                }
            
//                if let data = response.result.value {
//                    if let image = UIImage(data: data) {
//                        let newImage = image
//                    }
//                }
//            })
            
                //
//                    if let JSON = response.result.value as? [String : AnyObject], data = JSON["data"] as? [String : AnyObject] {
//                        if let champDictionary = data["Darius"] as? [String : AnyObject], image = champDictionary["image"] as? UIImage {
//                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                                
//                                if let id = champDictionary["id"] as? Int {
//                                    self?.champs.filter({ $0.idNumber == id }).map({ $0.image = image })
//                                    
//                                    self?.collectionView?.reloadData()
//                                }
//                            })
//                        }
//                    }
            }
        
    }
   
    //==========================================================================
    // MARK: - UICollectionViewDelegate
    //==========================================================================
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let champPage = ChampInfoViewController()
        champPage.nameLabel.text = champs[indexPath.item].name
        
//        presentViewController(navigationController, animated: true, completion: nil) //TODO: use this instead of push
        navigationController?.pushViewController(champPage, animated: true)
    }

    
    //==========================================================================
    // MARK: - Layout
    //==========================================================================
    
    lazy var flowlayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
       
        layout.minimumInteritemSpacing = 16.0;
        layout.minimumLineSpacing = 16.0;
        layout.itemSize = CGSize(width: 144.0, height: 144.0)
        
        return layout
    }()

}