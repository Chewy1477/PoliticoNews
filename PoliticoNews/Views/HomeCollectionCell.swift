//
//  HomeCollectionCell.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 9/28/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

final class HomeCollectionCell: UICollectionViewCell {
    var cellViewModel: ArticleViewCellViewModel? {
        didSet {
            guard let vm = cellViewModel else {
                return
            }
            
            articleTitle.text = vm.articleTitle
        }
    }
    
    let articleImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/1.38))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill

        return view
    }()
    
    fileprivate let articleTitle: UILabel = {
        let title = UILabel()
        title.layer.shadowOpacity = 4
        title.layer.shadowRadius = 4
        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowOffset = CGSize(width: 0, height: -1.0)
        title.textAlignment = .left
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 3
        
        return title
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func initialize() {
        
        self.articleImageView.addBlackGradientLayer(frame: articleImageView.bounds)

        contentView.addSubview(articleImageView)
        contentView.addSubview(articleTitle)
    
        contentView.addConstraint(NSLayoutConstraint(item: articleImageView, attribute: .centerX, relatedBy: .equal, toItem: contentView,
                                                     attribute: .centerX, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: articleImageView, attribute: .centerY, relatedBy: .equal, toItem: contentView,
                                                     attribute: .centerY, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: articleImageView, attribute: .height, relatedBy: .equal, toItem: nil,
                                                     attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/1.38))
        contentView.addConstraint(NSLayoutConstraint(item: articleImageView, attribute: .width, relatedBy: .equal, toItem: nil,
                                                     attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width))
        
        contentView.addConstraint(NSLayoutConstraint(item: articleTitle, attribute: .left, relatedBy: .equal, toItem: contentView,
                                                     attribute: .left, multiplier: 1.0, constant: 20))
        contentView.addConstraint(NSLayoutConstraint(item: articleTitle, attribute: .right, relatedBy: .equal, toItem: contentView,
                                                     attribute: .right, multiplier: 1.0, constant: -20))
        contentView.addConstraint(NSLayoutConstraint(item: articleTitle, attribute: .bottom, relatedBy: .equal, toItem: contentView,
                                                     attribute: .bottom, multiplier: 1.0, constant: -20))
        
    }
    
}
