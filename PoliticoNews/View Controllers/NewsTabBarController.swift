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
    
    private let tabBar: CustomTabBar = {
        let tab = CustomTabBar()
        tab.translatesAutoresizingMaskIntoConstraints = false
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        tabBar.delegate = self

        let viewControllers: [UIViewController] = [homeVC, favoritesVC]
//        let faveButton = FaveButton(
//            frame: CGRect(x:200, y: 200, width: 44, height: 44),
//            faveIconNormal: UIImage(named: "heart")
//        )
//
//        self.navigationItem.rightBarButtonItem?.customView = faveButton
        for vc in viewControllers {
            vc.view.backgroundColor = .white
            
            let nav = PTNavigationController()
            nav.viewControllers = [vc]
            
            addChildViewController(nav)
            
        }
        
        setViewControllers([homeVC], animated: false)
    }
    
    private func initialize() {
        
        view.addSubview(tabBar)
        
        view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        
    }
}

extension NewsTabBarController: CustomTabBarDelegate {
    func customTabBar(_ tabBar: CustomTabBar, didTapButtonAtIndex index: Int) {
        if index == 0 {
            setViewControllers([homeVC], animated: false)
        }
        else if index == 1 {
            setViewControllers([favoritesVC], animated: false)
        }

    }
}
        





