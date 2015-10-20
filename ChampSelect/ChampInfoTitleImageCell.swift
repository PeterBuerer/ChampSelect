//
//  ChampInfoImageCollectionViewCell.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/17/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import UIKit

class ChampInfoTitleImageCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        let views = ["image": imageView,
                     "title": titleLabel,
                    ]
        
        let metrics = ["Padding": 8.0,
                       "Margin": 16.0,
                       ]
        
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[image]-(Padding)-[title]-(Padding)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[image]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        titleLabel.centerXAnchor.constraintEqualToAnchor(contentView.centerXAnchor).active = true
    }
  
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    //==========================================================================
    // MARK: - Views
    //==========================================================================
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
       
        imageView.contentMode = .ScaleAspectFit
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(1000, forAxis: .Vertical)
        
        return label
    }()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}