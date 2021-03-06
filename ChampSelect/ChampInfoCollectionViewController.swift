//
//  ChampPageViewController.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/10/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import UIKit

class ChampInfoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
 
    var champ = Champ() //TODO: make this a view model object maybe
    
    var dataSource = ChampPageDataSource(champ: Champ())
    let titleCellIdentifier = "TitleCellIdentifier"
    let genericCellIdentifier = "GenericCellIdentifier"
    
    convenience init(champ: Champ) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        
        self.champ = champ
        navigationItem.title = champ.name
        self.dataSource = ChampPageDataSource(champ: champ)
        
        self.getDefaultSkin()
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
     
        collectionView?.collectionViewLayout = flowlayout
        collectionView?.registerClass(ChampInfoTitleImageCell.self, forCellWithReuseIdentifier: self.titleCellIdentifier)
        collectionView?.registerClass(ChampInfoGenericCell.self, forCellWithReuseIdentifier: self.genericCellIdentifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("dismiss"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.backgroundPrimary()
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
                strongSelf.dataSource.sections[0].items[0].image = image
                strongSelf.collectionView?.reloadItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
            })
        })
    }
    //==========================================================================
    // MARK: - UICollectionViewDataSource
    //==========================================================================
   
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.sections.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.sections[section].items.count
    }
   
    
    
    //TODO: make some header views to display section names
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
        let viewModel = dataSource.sections[indexPath.section].items[indexPath.item]
       
        switch(indexPath.section) {
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(titleCellIdentifier, forIndexPath: indexPath) as! ChampInfoTitleImageCell
           
            cell.imageView.image = viewModel.image
            cell.titleLabel.text = viewModel.title
            cell.titleLabel.backgroundColor = UIColor.cellPrimary()
            
            return cell
            break;
        default:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(genericCellIdentifier, forIndexPath: indexPath) as! ChampInfoGenericCell
            
            cell.titleLabel.text = viewModel.title
            cell.infoLabel.text = viewModel.info
            cell.backgroundColor = UIColor.cellPrimary()
            
            //TODO: get item info from viewmodel
            
            return cell
            break;
        }
    }
    
    
    //==========================================================================
    // MARK: - UICollectionViewDelegateFlowLayout
    //==========================================================================
 
    //TODO: revisit this later
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let viewModel = dataSource.sections[indexPath.section].items[indexPath.item]
        
        //TODO: call class method on cell to get content size
        switch(viewModel.size) {
            case .Small:
                 return smallCellSize
                
             case .Medium:
                 return mediumCellSize
                 
             case .Large:
                 return flowlayout.itemSize
        }
    }

    
    //==========================================================================
    // MARK: - Layout
    //==========================================================================
 
    static let itemWidth = (0.5 * 560.0)
    let smallCellSize = CGSize(width: itemWidth, height: 84.0)
    let mediumCellSize = CGSize(width: itemWidth, height: 256.0)
    
    lazy var flowlayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumInteritemSpacing = 16.0;
        layout.minimumLineSpacing = 16.0;
        layout.itemSize = CGSize(width: itemWidth, height: 560.0) //TODO: got these numbers by looking at the size of a loading image skin; should probably do something better then this
        let insets = CGFloat(16.0)
        layout.sectionInset = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
        
        return layout
    }()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}