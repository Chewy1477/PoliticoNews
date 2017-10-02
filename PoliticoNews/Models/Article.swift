//
//  Article.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 9/27/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

struct Article {
    let title: String
    let link: String
    let description: String
    let date: String
    let author: String
    let content: String
    
    init(title: String, link: String, description: String, date: String, author: String, content: String) {
        self.title = title
        self.link = link
        self.description = description
        self.date = date
        self.author = author
        self.content = content
    }
}
