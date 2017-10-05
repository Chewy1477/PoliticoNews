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
            
            let htmlData = NSString(string: avm.articleContent).data(using: String.Encoding.unicode.rawValue)
            let attributedString = try! NSMutableAttributedString(data: htmlData!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            
            let maintain: NSMutableAttributedString = attributedString
            maintain.beginEditing()
            maintain.enumerateAttribute(NSFontAttributeName, in: NSMakeRange(0, maintain.length), options: NSAttributedString.EnumerationOptions(rawValue: 0)) { (value, range, stop) -> Void in
                if let oldFont = value as? UIFont {
                    let newFont = oldFont.withSize(18)
                    maintain.removeAttribute(NSFontAttributeName, range: range)
                    maintain.addAttribute(NSFontAttributeName, value: newFont, range: range)
                }
            }
            maintain.endEditing()
            displayTextView.attributedText = maintain
        }
    }
    
    var displayImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/1.5))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true

        return view
    }()
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView: UIView = {
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
        let contents = UITextView()
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.isScrollEnabled = false
        contents.isDirectionalLockEnabled = true
        contents.alwaysBounceVertical = true
        contents.isEditable = false
        contents.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return contents
    }()
    
    // MARK: - Lifetime
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

        contentView.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .width, relatedBy: .equal, toItem: nil,
                                                     attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width))
        
        contentView.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .height, relatedBy: .equal, toItem: nil,
                                                     attribute: .notAnAttribute, multiplier: 1.0, constant: scrollView.contentSize.height))
        contentView.addConstraint(NSLayoutConstraint(item: displayTextView, attribute: .top, relatedBy: .equal, toItem: displayTitle,
                                                     attribute: .bottom, multiplier: 1.0, constant: 20))
        
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
