//
//  FavoritesTableCell.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 10/1/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

final class FavoritesTableCell: UITableViewCell {
    
    let myImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textAlignment = .left
        
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    init(frame: CGRect) {
        super.init(style: .default, reuseIdentifier: nil)
        initialize()
    }
    
    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    private func initialize() {
        contentView.addSubview(myImage)
        contentView.addSubview(title)

        
        contentView.addConstraint(NSLayoutConstraint(item: myImage, attribute: .bottom, relatedBy: .equal, toItem: contentView,
                                                     attribute: .bottom, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: myImage, attribute: .top, relatedBy: .equal, toItem: contentView,
                                                     attribute: .top, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: myImage, attribute: .left, relatedBy: .equal, toItem: contentView,
                                                     attribute: .left, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: myImage, attribute: .height, relatedBy: .equal, toItem: nil,
                                                     attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.height/8))
        contentView.addConstraint(NSLayoutConstraint(item: myImage, attribute: .width, relatedBy: .equal, toItem: nil,
                                                     attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/2.5))
        
        contentView.addConstraint(NSLayoutConstraint(item: title, attribute: .left, relatedBy: .equal, toItem: myImage,
                                                     attribute: .right, multiplier: 1, constant: 20))
        contentView.addConstraint(NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: contentView,
                                                     attribute: .top, multiplier: 1, constant: 10))
        contentView.addConstraint(NSLayoutConstraint(item: title, attribute: .right, relatedBy: .equal, toItem: contentView,
                                                     attribute: .right, multiplier: 1, constant: -20))
        
        
    }
}
