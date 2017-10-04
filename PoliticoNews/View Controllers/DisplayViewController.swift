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
    var checkSaved: [Favorite] = []

    var viewModel: ArticleViewCellViewModel? {
        didSet {
            guard let avm = viewModel else {
                return
            }
            displayTitle.text = avm.articleTitle
            displayImageView.image = #imageLiteral(resourceName: "temp")
            displayTextView.text = avm.articleContent
        }
    }
    
    var displayImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true

        return view
    }()
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        return scrollView
    }()
    
    var displayBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()

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
    
    var displayTextView: UITextView = {
        let contents = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.font = UIFont.systemFont(ofSize: 14)
        contents.isScrollEnabled = true
        contents.isDirectionalLockEnabled = true
        contents.alwaysBounceVertical = true
        return contents
    }()
    
    // MARK: - Lifetime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkSaved = CoreDataHelper.retrieveFavorites()
        
        if (checkSaved.count != 0) {
            for i in checkSaved {
                if (i.title == viewModel?.articleTitle) {
                    hasHeart = true
                }
            }
        }
        
        initialize()
    }

    private func initialize() {
        setInitialBarButton()
        
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: displayTextView.contentSize.height)
        
        scrollView.addSubview(displayImageView)
        scrollView.addSubview(displayBackgroundView)
        
        displayBackgroundView.addSubview(displayTitle)
//        displayBackgroundView.addSubview(displayTextView)
        
        view.addConstraint(NSLayoutConstraint(item: displayImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/1.5))
        view.addConstraint(NSLayoutConstraint(item: displayImageView, attribute: .top, relatedBy: .equal, toItem: view,
                                              attribute: .top, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: displayImageView, attribute: .width, relatedBy: .equal, toItem: nil,
                                              attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width))

        view.addConstraint(NSLayoutConstraint(item: displayBackgroundView, attribute: .top, relatedBy: .equal, toItem: displayImageView,
                                              attribute: .bottom, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: displayBackgroundView, attribute: .bottom, relatedBy: .equal, toItem: view,
                                              attribute: .bottom, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: displayBackgroundView, attribute: .width, relatedBy: .equal, toItem: nil,
                                              attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width))

        
        view.addConstraint(NSLayoutConstraint(item: displayTitle, attribute: .left, relatedBy: .equal, toItem: view,
                                              attribute: .left, multiplier: 1.0, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: displayTitle, attribute: .right, relatedBy: .equal, toItem: view,
                                              attribute: .right, multiplier: 1.0, constant: -20))
        view.addConstraint(NSLayoutConstraint(item: displayTitle, attribute: .top, relatedBy: .equal, toItem: displayImageView,
                                              attribute: .bottom, multiplier: 1.0, constant: 20))
        
        
//        view.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .top, relatedBy: .equal, toItem: displayTitle,
//                                              attribute: .bottom, multiplier: 1.0, constant: 30))
//            //view.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .bottom, relatedBy: .equal, toItem: displayBackgroundView, attribute: .bottom, multiplier: 1.0, constant: 0))
//            view.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/2))
//            view.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1.0, constant: UIScreen.main.bounds.height-displayImageView.frame.height))
    }
    
    func setInitialBarButton() {
        if (hasHeart == false) {
            createRightBarButtonItem(image: #imageLiteral(resourceName: "unfavorited"))
        }
        else {
            createRightBarButtonItem(image: #imageLiteral(resourceName: "favorited"))
        }
    }
    
    func executeUpdates() {
        if (hasHeart == false) {
            createRightBarButtonItem(image: #imageLiteral(resourceName: "favorited"))
            hasHeart = true
            addToFavorites()
        }
        
        else {
            checkSaved = CoreDataHelper.retrieveFavorites()
            hasHeart = false
            createRightBarButtonItem(image: #imageLiteral(resourceName: "unfavorited"))
            let toDelete = checkSaved.filter { $0.title == viewModel?.articleTitle }
            CoreDataHelper.delete(favorite: toDelete[0])
        }
    }
    
    func createRightBarButtonItem(image: UIImage) {
        let heart = UIButton(type: .custom)
        heart.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        heart.addTarget(self, action: #selector(self.executeUpdates), for: .touchUpInside)
        
        let heartImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        heartImage.contentMode = .scaleToFill
        heartImage.image = image
        heart.addSubview(heartImage)

        let barButton = UIBarButtonItem(customView: heart)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func addToFavorites() {
        let create = CoreDataHelper.newFavorite()
        
        guard let vm = viewModel else {
            return
        }
        
        create.title = vm.articleTitle
        create.content = vm.articleContent
        create.author = vm.articleAuthor
        CoreDataHelper.saveFavorite()
    }
}

extension DisplayViewController: UIScrollViewDelegate {
    
}
