//
//  ArticleSerialization.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 9/26/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit
import SWXMLHash

public final class ArticleSerialization {
    
    static func articles(data: Data) throws -> [Article] {
        var arrArticles: [Article] = []
        
        do {
            let xml = SWXMLHash.config {
                config in
                }.parse(data)
            
            let items = xml["rss"]["channel"]["item"]
            let numberOfArticles = items.all.count
            
            for i in 0..<numberOfArticles {
                
                let articleName = items[i]["title"].element?.text ?? ""
                
                let articleLink = items[i]["link"].element?.text ?? ""
                
                let articleDescription = items[i]["description"].element?.text ?? ""
                
                let articleDate = items[i]["pubDate"].element?.text ?? ""
                
                let articleAuthor = items[i]["author"].element?.text ?? ""
                
                let articleContent = items[i]["content:encoded"].element?.text ?? ""
            
            
            let article = Article(title: articleName, link: articleLink, description: articleDescription, date: articleDate, author: articleAuthor, content: articleContent)
            arrArticles.append(article)
            }
            return arrArticles
        }
    }
}
