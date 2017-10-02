//
//  UIView+PoliticoNews.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 9/28/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

extension UIView {
    
    func addToAndConstrain(insideSuper view: UIView) {
        view.addSubview(self)
        view.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view,
                                              attribute: .top, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view,
                                              attribute: .left, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view,
                                              attribute: .right, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view,
                                              attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    
}
