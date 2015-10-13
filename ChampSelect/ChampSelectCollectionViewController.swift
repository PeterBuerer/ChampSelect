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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Legal", style: .Done, target: self, action: Selector("showLegal"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        updateChamps()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "Champ Select"
        
        collectionView?.hidden = true
    }
    
    //==========================================================================
    // MARK: - Actions
    //==========================================================================

    func showLegal() {
        let legalViewController = LegalViewController()
        let navVC = UINavigationController(rootViewController: legalViewController)
        
        presentViewController(navVC, animated: true, completion: nil)
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
        cell.imageView.image = champ.iconImage
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
            ChampManager.defaultChampManager.champIconImage(champ, completion: { [weak self] (image) -> () in
                guard let image = image, strongSelf = self else { return }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    strongSelf.champs[index].iconImage = image
                    strongSelf.collectionView?.reloadItemsAtIndexPaths([NSIndexPath(forItem: index, inSection: 0)]) //TODO: find a way to make this not a hard coded number
                })
            })
           
            //load default skin image
            ChampManager.defaultChampManager.champLoadingScreenImage(champ, skinNumber: 0, completion: { [weak self] (image) -> () in
                guard let strongSelf = self where strongSelf.champs[index].skins.count > 0 else { return }
                strongSelf.champs[index].skins[0].image = image
            })
        }
        
    }
   
    //==========================================================================
    // MARK: - UICollectionViewDelegate
    //==========================================================================
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let champPage = ChampInfoViewController(champ: champs[indexPath.item])
       
        let navController = UINavigationController(rootViewController: champPage)
        presentViewController(navController, animated: true, completion: nil) //TODO: use this instead of push
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

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}