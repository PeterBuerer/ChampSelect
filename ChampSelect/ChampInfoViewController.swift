//
//  ChampPageViewController.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/10/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import UIKit

class ChampInfoViewController: UIViewController {
 
    var champ = Champ() //TODO: make this a view model object maybe
    
    init(champ: Champ) {
        self.champ = champ
        
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("dismiss"))
        navigationItem.title = champ.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = champ.skins["default"]?.image
       
        //just picking a random skin right now
        ChampManager.defaultChampManager.champLoadingScreenImage(champ.imageName, skinNumber: Int(arc4random_uniform(UInt32(champ.skins.count))), completion: { [weak self] (image) -> () in
            
            dispatch_async(dispatch_get_main_queue(), { [weak self] () -> Void in
               
                UIView.animateWithDuration(0.45, delay: 0.0, options: .CurveEaseInOut, animations: { [weak self] () -> Void in
                    guard let strongSelf = self else { return }
                    strongSelf.imageView.image = image
                }, completion: nil)
                
            })
        })
        
        view.addSubview(imageView)
        
        let views = ["image": imageView,
                     ]
        NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[image]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[image]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
   
    //==========================================================================
    // MARK: - Actions
    //==========================================================================
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //==========================================================================
    // MARK: - Views
    //==========================================================================
   
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}