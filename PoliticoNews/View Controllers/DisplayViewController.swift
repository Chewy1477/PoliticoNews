//
//  DisplayViewController.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 9/29/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

final class DisplayViewController: PTViewController {
    
    var hasHeart: Bool = false
    var favorite: Favorite?

    var favoritesViewModel: FavoriteViewCellViewModel? {
        didSet {
            guard let fvm = favoritesViewModel else {
                return
            }
        }
    }
    
    var viewModel: ArticleViewCellViewModel? {
        didSet {
            guard let avm = viewModel else {
                return
            }
            displayTitle.text = avm.articleTitle
            displayImageView.image = #imageLiteral(resourceName: "temp")
            displayTextView.text = avm.articleDescription            
        }
    }
    
    var displayImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true

        return view
    }()
    
    var displayBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var heartImageView: UIImageView {
        let heartImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        if (hasHeart) {
            heartImage.image = #imageLiteral(resourceName: "unfavorited")
        }
            
        else {
            heartImage.image = #imageLiteral(resourceName: "favorited")
        }
        
        heartImage.contentMode = .scaleToFill
        return heartImage
    }
    
    var customBarButton: UIBarButtonItem {
        let heart = UIButton(type: .custom)
        
        heart.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        heart.addSubview(heartImageView)
        heart.addTarget(self, action: #selector(self.heartStatus), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: heart)

        return barButton
    }
    
    var displayTitle: UILabel = {
        let title = UILabel()
        title.layer.shadowOpacity = 0.5
        title.layer.shadowRadius = 0.5
        title.layer.shadowColor = UIColor.gray.cgColor
        title.layer.shadowOffset = CGSize(width: 0, height: -0.5)
        title.textAlignment = .left
        title.textColor = .black
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 3
        
        return title
    }()
    
    var displayTextView: UITextView {
        let contents = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        contents.translatesAutoresizingMaskIntoConstraints = false
        return contents
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        heartStatus()
        
        view.addSubview(displayImageView)
        view.addSubview(displayBackgroundView)
        
        displayBackgroundView.addSubview(displayTitle)
        displayBackgroundView.addSubview(displayTextView)
        
        view.addConstraint(NSLayoutConstraint(item: displayImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/1.5))
        view.addConstraint(NSLayoutConstraint(item: displayImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: displayImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width))
        
//        view.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .top, relatedBy: .equal, toItem: displayTitle, attribute: .bottom, multiplier: 1.0, constant: 0))
//        view.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width-20))

        view.addConstraint(NSLayoutConstraint(item: displayBackgroundView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width))
        view.addConstraint(NSLayoutConstraint(item: displayBackgroundView, attribute: .top, relatedBy: .equal, toItem: displayImageView, attribute: .bottom, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: displayBackgroundView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1000))
        
        view.addConstraint(NSLayoutConstraint(item: displayTitle, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: displayTitle, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -20))
        view.addConstraint(NSLayoutConstraint(item: displayTitle, attribute: .top, relatedBy: .equal, toItem: displayImageView, attribute: .bottom, multiplier: 1.0, constant: 20))
    
    }
    
    func heartStatus() {
        if (hasHeart == false) {
            hasHeart = true
            addToFavorites()
        }
        else {
            hasHeart = false
        }
        self.navigationItem.rightBarButtonItem = customBarButton
    }
    
    func addToFavorites() {
        let create = self.favorite ?? CoreDataHelper.newFavorite()
        
        guard let vm = viewModel else {
            return
        }
        
        create.title = vm.articleTitle
        create.content = vm.articleContent
        create.author = vm.articleAuthor
        CoreDataHelper.saveFavorite()
    }
}
