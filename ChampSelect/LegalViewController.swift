//
//  LegalViewController.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/11/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import UIKit

class LegalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("dismiss"))
        
        view.addSubview(legalLabel)
        view.backgroundColor = UIColor.blackColor()
        
        let views = ["label": legalLabel
                     ]
        
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(16.0)-[label]-(16.0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(16.0)-[label]-(16.0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
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
    
    lazy var legalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        
        label.text = "Champ Select isn't endorsed by Riot Games and doesn't reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc."
        
        return label
    }()

}