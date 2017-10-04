//
//  ArticleViewModel.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 9/27/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

protocol ArticleCellProtocol: AnyObject {
    var articleTitle: String { get }
    var articleDate: String { get }
    var articleAuthor: String { get }
    var articleContent: String { get }
    var articleDescription: String { get }
}

class ArticleViewCellViewModel: ArticleCellProtocol {
    private let myArticle: Article
    
    var articleTitle: String {
        return myArticle.title
    }
    
    var articleDate: String {
       return myArticle.date
    }
    
    var articleAuthor: String {
        return myArticle.author
    }
    
    
    var articleContent: String {
        let content = myArticle.content
        
        let firstTag = content.replacingOccurrences(of: "<p>", with: "")
        let endTag = firstTag.replacingOccurrences(of: "</p>", with: "\n")
        
        return endTag
    }
    
    var articleDescription: String {
        return myArticle.description
    }
    
    init(withArticle article: Article) {
        self.myArticle = article
    }
}

typealias ArticleViewModel = [ArticleViewCellViewModel]
