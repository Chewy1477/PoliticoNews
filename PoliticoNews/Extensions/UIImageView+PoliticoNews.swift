//
//  UIImageView+PoliticoNews.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 10/5/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

extension UIImageView {
    func addBlackGradientLayer(frame: CGRect) {
        clipsToBounds = true
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
