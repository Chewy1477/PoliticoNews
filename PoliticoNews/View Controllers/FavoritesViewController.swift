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
    
    var favorites: [Favorite] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favorites = CoreDataHelper.retrieveFavorites()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.clear
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
        let selected = favorites[indexPath.row]
        
        let title = selected.title ?? ""
        let description = selected.descrip ?? ""
        let content = selected.content ?? ""
        let author = selected.author ?? ""
        let date = selected.date ?? ""
        
        let toPass = Article(title: title, description: description, content: content, author: author, date: date)
        
        displayVC.viewModel = ArticleViewCellViewModel(withArticle: toPass)
        navigationController?.pushViewController(displayVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/8
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
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableCell.description(), for: indexPath) as! FavoritesTableCell
        
        let row = indexPath.row
        let favorite = favorites[row]

        cell.title.text = favorite.title
        cell.myImage.image = #imageLiteral(resourceName: "temp")
        return cell
    }
}
