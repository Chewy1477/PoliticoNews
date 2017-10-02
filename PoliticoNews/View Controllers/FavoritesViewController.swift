//
//  FavoritesViewController.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 9/27/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

final class FavoritesViewController: PTViewController {
    
    fileprivate let tableView: UITableView = {
        let view = UITableView()
        view.register(FavoritesTableCell.self, forCellReuseIdentifier: FavoritesTableCell.description())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tableViewModel: FavoriteViewModel?

    var favorites: [Favorite] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favorites = CoreDataHelper.retrieveFavorites()
        
        self.tableViewModel = self.favorites.map({(parameter: Favorite) -> FavoriteViewCellViewModel in
            return FavoriteViewCellViewModel(withFavorite: parameter)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.title = "Favorites"
    }
    
    private func initialize() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addToAndConstrain(insideSuper: view)

    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayVC = DisplayViewController()
        
        displayVC.favoritesViewModel = FavoriteViewCellViewModel(withFavorite: favorites[indexPath.row])
        navigationController?.pushViewController(displayVC, animated: true)
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //1
            CoreDataHelper.delete(favorite: favorites[indexPath.row])
            //2
            favorites = CoreDataHelper.retrieveFavorites()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableCell.description(), for: indexPath) as! FavoritesTableCell
        
        let row = indexPath.row
        let favorite = favorites[row]
        cell.title.text = favorite.title
        
        return cell
    }
}
