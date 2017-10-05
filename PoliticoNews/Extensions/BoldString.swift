//
//  NSMutableAttributedString+PoliticoNews.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 10/4/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func bold(_ text: String) -> NSMutableAttributedString {
        let att = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16)]
        let boldString = NSMutableAttributedString(string: text, attributes: att)
        self.append(boldString)
        return self
    }
    
    func normal(_ text:String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        self.append(normal)
        return self
    }
    
    func italicize(_ text: String) -> NSMutableAttributedString {
        let att = [NSFontAttributeName : UIFont.italicSystemFont(ofSize: 16)]
        let italicizedString = NSMutableAttributedString(string: text, attributes: att)
        self.append(italicizedString)
        return self
    }
}
