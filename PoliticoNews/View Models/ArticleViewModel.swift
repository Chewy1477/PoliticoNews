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
    var articleDescription: String { get }
    var articleDate: String { get }
    var articleAuthor: String { get }
    var articleContent: String { get }
}

class ArticleViewCellViewModel: ArticleCellProtocol {
    let myArticle: Article
    
    var articleTitle: String {
        return myArticle.title
    }
    
    var articleDescription: String {
        return myArticle.description
    }
    
    var articleDate: String {
        return myArticle.date
    }
    
    var articleAuthor: String {
        return myArticle.author
    }
    
    
    var articleContent: String {
        return myArticle.content
    }
    
    init(withArticle article: Article) {
        self.myArticle = article
    }
}

typealias ArticleViewModel = [ArticleViewCellViewModel]
