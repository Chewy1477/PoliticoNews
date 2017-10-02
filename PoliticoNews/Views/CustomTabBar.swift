//
//  CustomTabBar.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 9/27/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

protocol CustomTabBarDelegate: AnyObject {
    func customTabBar(_ tabBar: CustomTabBar, didTapButtonAtIndex index: Int)
}

class CustomTabBar: UIView {
    
    weak var delegate: CustomTabBarDelegate?
    
    var topBarViewCenterX: NSLayoutConstraint = NSLayoutConstraint()
    var midBarViewCenterX: NSLayoutConstraint = NSLayoutConstraint()
    var midBarViewCenterY: NSLayoutConstraint = NSLayoutConstraint()
    
    //blur view
    fileprivate let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let effect = UIBlurEffect(style: UIBlurEffectStyle.light)
        view.effect = effect
        return view
    }()
    
    //top bar view
    fileprivate let topBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        return view
    }()
    
    //middle bar view
    fileprivate let midBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    fileprivate let homeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        return button
    }()
    
    fileprivate let homeLabel: UILabel = {
        let label = UILabel()
        label.text = "Top News"
        label.textColor = UIColor.red
        return label
    }()
    
    fileprivate let favoritesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black

        return button
    }()
    
    fileprivate let favoritesLabel: UILabel = {
        let favorites = UILabel()
        favorites.text = "Favorites"
        favorites.textColor = UIColor.red
        return favorites
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
        super.init(frame:frame)
        initialize()
    }
    
    deinit {
        homeButton.removeTarget(self, action: nil, for: .allEvents)
        favoritesButton.removeTarget(self, action: nil, for: .allEvents)
        
    }
    
    private func initialize() {
        
        addSubview(homeButton)
        homeButton.addSubview(topBarView)
        homeButton.addSubview(homeLabel)
        homeButton.addSubview(midBarView)

        homeLabel.frame = CGRect(x: 0, y: homeButton.frame.origin.y, width: homeLabel.intrinsicContentSize.width, height: 50)
        homeLabel.center.x = UIScreen.main.bounds.width/4
        
        addSubview(favoritesButton)
        favoritesButton.addSubview(topBarView)
        favoritesButton.addSubview(favoritesLabel)
        favoritesButton.addSubview(midBarView)
        
        favoritesLabel.frame = CGRect(x: 0, y: homeButton.frame.origin.y, width: favoritesLabel.intrinsicContentSize.width, height: 50)
        favoritesLabel.center.x = (UIScreen.main.bounds.width/4)

        homeButton.addTarget(self, action: #selector(CustomTabBar.didTapButton(sender:)), for: .touchUpInside)
        favoritesButton.addTarget(self, action: #selector(CustomTabBar.didTapButton(sender:)), for: .touchUpInside)
     
        //top bar view constraints
        addConstraint(NSLayoutConstraint(item: topBarView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: topBarView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 3.0))
        addConstraint(NSLayoutConstraint(item: topBarView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/4))
        topBarViewCenterX = NSLayoutConstraint(item: topBarView, attribute: .centerX, relatedBy: .equal, toItem: homeButton, attribute: .centerX, multiplier: 1.0, constant: 0)
        addConstraint(topBarViewCenterX)
        
        //mid bar view constraints

        addConstraint(NSLayoutConstraint(item: midBarView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: midBarView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.5))
        midBarViewCenterX = NSLayoutConstraint(item: midBarView, attribute: .centerX, relatedBy: .equal, toItem: homeButton, attribute: .right, multiplier: 1.0, constant: 0)
        midBarViewCenterY = NSLayoutConstraint(item: midBarView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -25)
        
        addConstraint(midBarViewCenterY)
        addConstraint(midBarViewCenterX)
        
        //home button
        addConstraint(NSLayoutConstraint(item: homeButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/2))
        
        //favorites button
        addConstraint(NSLayoutConstraint(item: favoritesButton, attribute: .left, relatedBy: .equal, toItem: homeButton, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: favoritesButton, attribute: .top, relatedBy: .equal, toItem: homeButton, attribute: .top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: favoritesButton, attribute: .bottom, relatedBy: .equal, toItem: homeButton, attribute: .bottom, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: favoritesButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/2))
    }
    
    func didTapButton(sender: UIButton) {
        switch sender {
        case homeButton:
            delegate?.customTabBar(self, didTapButtonAtIndex: 0)
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    self.homeLabel.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.0)
            },
                completion: { finish in
                    UIView.animate(
                        withDuration: 0.3,
                        delay: 0.0,
                        options: .curveEaseOut,
                        animations: {
                            self.homeLabel.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
                    },
                        completion: nil)})
            
            topBarViewCenterX.constant = 0
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    self.layoutIfNeeded()
            },
                completion: nil)
            
            
        case favoritesButton:
            delegate?.customTabBar(self, didTapButtonAtIndex: 1)
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    self.favoritesLabel.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.0)
            },
                completion: { finish in
                    UIView.animate(
                        withDuration: 0.3,
                        delay: 0.0,
                        options: .curveEaseOut,
                        animations: {
                            self.favoritesLabel.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
                    },
                        completion: nil)})
            
            topBarViewCenterX.constant = UIScreen.main.bounds.width/2
            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                options: .curveEaseOut,
                animations: {
                    self.layoutIfNeeded()
            },
                completion: nil)
        default: return
        }
    }
    
}
