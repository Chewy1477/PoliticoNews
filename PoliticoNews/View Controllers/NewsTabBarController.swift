//
//  ViewController.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 9/25/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

final class NewsTabBarController: UINavigationController {
    
    fileprivate let homeVC = HomeViewController()
    fileprivate let favoritesVC = FavoritesViewController()
    
    private let tabBar: NewsTabBar = {
        let tab = NewsTabBar()
        tab.translatesAutoresizingMaskIntoConstraints = false
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        tabBar.delegate = self

        let viewControllers: [UIViewController] = [homeVC, favoritesVC]

        for vc in viewControllers {
            vc.view.backgroundColor = .darkGray
            
            let nav = PTNavigationController()
            nav.viewControllers = [vc]
            
            addChildViewController(nav)
            
        }
        
        setViewControllers([homeVC], animated: false)
    }
    
    fileprivate func initialize() {
        
        view.addSubview(tabBar)
        
        view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .left, relatedBy: .equal, toItem: view,
                                              attribute: .left, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .right, relatedBy: .equal, toItem: view,
                                              attribute: .right, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .bottom, relatedBy: .equal, toItem: view,
                                              attribute: .bottom, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .height, relatedBy: .equal, toItem: nil,
                                              attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        
    }
}

extension NewsTabBarController: CustomTabBarDelegate {
    func customTabBar(_ tabBar: NewsTabBar, didTapButtonAtIndex index: Int) {
        if index == 0 {
            setViewControllers([homeVC], animated: false)
        }
        else if index == 1 {
            setViewControllers([favoritesVC], animated: false)
        }

    }
}
        





