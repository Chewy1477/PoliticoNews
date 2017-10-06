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
            displayAuthor.text = avm.articleAuthor
            displayDate.text = avm.articleDate
            
            let formatted = NSMutableAttributedString()
            displayTextView.attributedText = formatted.changeAttributes(text: avm.articleContent)
        }
    }
    
    fileprivate let displayImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/1.5))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true

        return view
    }()
    
    fileprivate let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    fileprivate let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()

    fileprivate let displayTitle: UILabel = {
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
    
    fileprivate let displayAuthor: UILabel = {
        let author = UILabel()
        author.textAlignment = .left
        author.textColor = .black
        author.font = UIFont.italicSystemFont(ofSize: 14)
        author.translatesAutoresizingMaskIntoConstraints = false
        author.numberOfLines = 1
        
        return author
    }()
    
    fileprivate let displayDate: UILabel = {
        let date = UILabel()
        date.textAlignment = .left
        date.textColor = UIColor.darkGray
        date.font = UIFont.systemFont(ofSize: 14)
        date.translatesAutoresizingMaskIntoConstraints = false
        date.numberOfLines = 1
        
        return date
    }()
    
    fileprivate let displayTextView: UITextView = {
        let contents = UITextView()
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.isScrollEnabled = true
        contents.isDirectionalLockEnabled = true
        contents.alwaysBounceVertical = true
        contents.isEditable = false
        contents.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        contents.font = UIFont(name: "Helvetica", size: 20)
        return contents
    }()
    
    // MARK: - Lifetime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = true

        self.view.backgroundColor = UIColor.darkGray
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = self.view.bounds
        contentView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }

    private func initialize() {
        setInitialBarButton()
        displayTextView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: displayTextView.contentSize.height)
        displayTextView.sizeToFit()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(displayImageView)

        contentView.addSubview(displayTitle)
        contentView.addSubview(displayAuthor)
        contentView.addSubview(displayDate)
        contentView.addSubview(displayTextView)
        
        var height: CGFloat = 0
        for view in contentView.subviews {
            height += view.frame.size.height
        }
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: height + 200)

        scrollView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: scrollView,
                                                    attribute: .bottom, multiplier: 1.0, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: nil,
                                                    attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width))
        scrollView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem:   displayTextView,
                                                    attribute: .bottom, multiplier: 1.0, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: displayImageView, attribute: .height, relatedBy: .equal, toItem: nil,
                                                     attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/1.5))
        contentView.addConstraint(NSLayoutConstraint(item: displayImageView, attribute: .top, relatedBy: .equal, toItem: contentView,
                                                     attribute: .top, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: displayImageView, attribute: .width, relatedBy: .equal, toItem: nil,
                                                     attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width))

        contentView.addConstraint(NSLayoutConstraint(item: displayTitle, attribute: .left, relatedBy: .equal, toItem: contentView,
                                                     attribute: .left, multiplier: 1.0, constant: 20))
        contentView.addConstraint(NSLayoutConstraint(item: displayTitle, attribute: .right, relatedBy: .equal, toItem: contentView,
                                                     attribute: .right, multiplier: 1.0, constant: -20))
        contentView.addConstraint(NSLayoutConstraint(item: displayTitle,attribute: .top, relatedBy: .equal, toItem: displayImageView,
                                                     attribute: .bottom, multiplier: 1.0, constant: 20))
        
        contentView.addConstraint(NSLayoutConstraint(item: displayAuthor, attribute: .left, relatedBy: .equal, toItem: contentView,
                                                     attribute: .left, multiplier: 1.0, constant: 20))
        contentView.addConstraint(NSLayoutConstraint(item: displayAuthor, attribute: .right, relatedBy: .equal, toItem: contentView,
                                                     attribute: .right, multiplier: 1.0, constant: -20))
        contentView.addConstraint(NSLayoutConstraint(item: displayAuthor,attribute: .top, relatedBy: .equal, toItem: displayTitle,
                                                     attribute: .bottom, multiplier: 1.0, constant: 15))
        
        contentView.addConstraint(NSLayoutConstraint(item: displayDate, attribute: .left, relatedBy: .equal, toItem: contentView,
                                                     attribute: .left, multiplier: 1.0, constant: 20))
        contentView.addConstraint(NSLayoutConstraint(item: displayDate, attribute: .right, relatedBy: .equal, toItem: contentView,
                                                     attribute: .right, multiplier: 1.0, constant: -20))
        contentView.addConstraint(NSLayoutConstraint(item: displayDate,attribute: .top, relatedBy: .equal, toItem: displayAuthor,
                                                     attribute: .bottom, multiplier: 1.0, constant: 15))

        contentView.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .width, relatedBy: .equal, toItem: nil,
                                                     attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width))
        contentView.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .height, relatedBy: .equal, toItem: nil,
                                                     attribute: .notAnAttribute, multiplier: 1.0, constant: scrollView.contentSize.height))
        contentView.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .top, relatedBy: .equal, toItem: displayDate,
                                                     attribute: .bottom, multiplier: 1.0, constant: 25))
        
    }
    
    fileprivate func setInitialBarButton() {
        if (hasHeart == false) {
            createRightBarButtonItem(image: #imageLiteral(resourceName: "unfavorited"))
        }
        else {
            createRightBarButtonItem(image: #imageLiteral(resourceName: "favorited"))
        }
    }
    
    @objc fileprivate func executeUpdates() {
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
    
    fileprivate func createRightBarButtonItem(image: UIImage) {
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
    
    fileprivate func addToFavorites() {
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

