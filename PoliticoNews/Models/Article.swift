//
//  News.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 10/3/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

struct Article {
    let title: String
    let description: String
    let content: NSMutableAttributedString
    let author: String
    let date: String
    
    init(title: String, description: String, content: NSMutableAttributedString, author: String, date: String) {
        self.title = title
        self.description = description
        self.content = content
        self.author = author
        self.date = date
    }

}
