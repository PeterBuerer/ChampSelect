//
//  ChampSelectCollectionViewCell.swift
//  ChampSelect
//
//  Created by Peter Buerer on 10/6/15.
//  Copyright © 2015 Peter Buerer. All rights reserved.
//

import UIKit

class ChampSelectCollectionViewCell: UICollectionViewCell {
   
    
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
        
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[image]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[image]-(Padding)-[title(>=Margin)]-(Padding)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(Margin)-[title]-(Margin)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
    }
  
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        imageView.image = nil
    }
    
    //==========================================================================
    // MARK: - Views
    //==========================================================================

    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}