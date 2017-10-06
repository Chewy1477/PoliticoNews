//
//  NSMutableAttributedString+PoliticoNews.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 10/4/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func changeAttributes(text: String) -> NSMutableAttributedString {
        guard let htmlData = NSString(string: text).data(using: String.Encoding.unicode.rawValue) else {
            return NSMutableAttributedString().normal("")
        }
        
        let attributedString = try! NSMutableAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        
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
        return maintain

    }
    
    func normal(_ text: String) -> NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}
