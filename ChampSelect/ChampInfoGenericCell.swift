//
//  ChampInfoGenericCell.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/19/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import UIKit

class ChampInfoGenericCell: UICollectionViewCell {
  
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        layer.cornerRadius = 6.0
        clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        
        let views = ["title": titleLabel,
                     "info": infoLabel,
                    ]
        
        let metrics = ["Padding": 8.0,
            "Margin": 16.0,
        ]
        
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(Margin)-[title]-(Margin)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(Margin)-[info]-(Margin)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(Margin)-[title]-(Padding)-[info]-(>=Margin)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        infoLabel.text = nil
    }
    
    //==========================================================================
    // MARK: - Views
    //==========================================================================
   
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFontOfSize(17.0)
        
        return label
    }()

    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.contentMode = .Top
        
        return label
    }()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}