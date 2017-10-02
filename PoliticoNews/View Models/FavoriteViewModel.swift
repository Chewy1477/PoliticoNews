//
//  FavoriteViewModel.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 10/2/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

protocol FavoriteCellProtocol: AnyObject {
    var favoriteTitle: String { get }
    var favoriteDate: String { get }
    var favoriteAuthor: String { get }
    var favoriteContent: String { get }
}

class FavoriteViewCellViewModel: FavoriteCellProtocol {
    let myFavorite: Favorite
    
    var favoriteTitle: String {
        guard let title = myFavorite.title else {
            return ""
        }
        return title
    }
    
    var favoriteDate: String {
        guard let date = myFavorite.date else {
            return ""
        }
        return date
    }
    
    var favoriteAuthor: String {
        guard let author = myFavorite.author else {
            return ""
        }
        return author
    }
    
    
    var favoriteContent: String {
        guard let content = myFavorite.content else {
            return ""
        }
        return content
    }
    
    init(withFavorite favorite: Favorite) {
        self.myFavorite = favorite
    }
}

typealias FavoriteViewModel = [FavoriteViewCellViewModel]
