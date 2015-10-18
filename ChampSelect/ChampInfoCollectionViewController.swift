//
//  ChampPageViewController.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/10/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import UIKit

class ChampInfoCollectionViewController: UICollectionViewController {
 
    var champ = Champ() //TODO: make this a view model object maybe
    let titleCellIdentifier = "TitleCellIdentifier"
    
    convenience init(champ: Champ) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        
        self.champ = champ
        navigationItem.title = champ.name
        
        self.getDefaultSkin()
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
      
        collectionView?.collectionViewLayout = flowlayout
        collectionView?.registerClass(ChampInfoTitleImageCollectionViewCell.self, forCellWithReuseIdentifier: self.titleCellIdentifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("dismiss"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
    }
   
    //==========================================================================
    // MARK: - Actions
    //==========================================================================
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getDefaultSkin() {
       
        //if the skin is already available, do nothing
        if let _ = champ.skins[0].image {
            return
        }
        
        ChampManager.defaultChampManager.champLoadingScreenImage(champ, skinNumber: 0, completion: { [weak self] (image) -> () in
            dispatch_async(dispatch_get_main_queue(), { [weak self] () -> Void in
                guard let strongSelf = self else { return }
                strongSelf.champ.skins[0].image = image
            })
        })
    }
    //==========================================================================
    // MARK: - UICollectionViewDataSource
    //==========================================================================
   
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(titleCellIdentifier, forIndexPath: indexPath) as! ChampInfoTitleImageCollectionViewCell
       
        cell.imageView.image = champ.skins[0].image
        cell.titleLabel.text = champ.title
        
        return cell
    }

    
    //==========================================================================
    // MARK: - Layout
    //==========================================================================
  
    lazy var flowlayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumInteritemSpacing = 16.0;
        layout.minimumLineSpacing = 16.0;
        layout.itemSize = CGSize(width: 256.0, height: 256.0)
        
        return layout
    }()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}