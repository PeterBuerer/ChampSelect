//
//  ChampPageViewController.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/10/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import UIKit

class ChampInfoViewController: UIViewController {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(nameLabel)
        
        let views = ["name": nameLabel]
        
        NSLayoutConstraint(item: nameLabel, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: -32.0).active = true
        NSLayoutConstraint(item: nameLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
//        NSLayoutConstraint(item: nameLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: nameLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0.0).active = true
        
        view.backgroundColor = UIColor.greenColor()
    }
    
    //==========================================================================
    // MARK: - Views
    //==========================================================================
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

}