//
//  FavoritesTableCell.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 10/1/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

final class FavoritesTableCell: UITableViewCell {
    
    var cellViewModel: ArticleViewCellViewModel? {
        didSet {
            guard let avm = cellViewModel else {
                return
            }
        }
    }
    
    fileprivate var myImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var release: UILabel = {
        let date = UILabel()
        date.textAlignment = .left
        date.textColor = .black
        date.font = UIFont.systemFont(ofSize: 12)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    fileprivate var price: UILabel = {
        let cost = UILabel()
        cost.textAlignment = .left
        cost.textColor = .black
        cost.font = UIFont.systemFont(ofSize: 12)
        cost.translatesAutoresizingMaskIntoConstraints = false
        return cost
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
        contentView.addSubview(release)
        contentView.addSubview(price)
        
        contentView.addConstraint(NSLayoutConstraint(item: myImage, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -10))
        contentView.addConstraint(NSLayoutConstraint(item: myImage, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 10))
        contentView.addConstraint(NSLayoutConstraint(item: myImage, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 10))
        
        
        contentView.addConstraint(NSLayoutConstraint(item: title, attribute: .left, relatedBy: .equal, toItem: myImage, attribute: .right, multiplier: 1, constant: 15))
        contentView.addConstraint(NSLayoutConstraint(item: title, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -30))
        contentView.addConstraint(NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20))
        
        contentView.addConstraint(NSLayoutConstraint(item: release, attribute: .top, relatedBy: .equal, toItem: title, attribute: .bottom, multiplier: 1, constant: 5))
        contentView.addConstraint(NSLayoutConstraint(item: release, attribute: .left, relatedBy: .equal, toItem: myImage, attribute: .right, multiplier: 1, constant: 15))
        contentView.addConstraint(NSLayoutConstraint(item: release, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 70))
        
        contentView.addConstraint(NSLayoutConstraint(item: price, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: price, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -30))
        
    }
}
