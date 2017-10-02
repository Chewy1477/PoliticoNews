//
//  FavoritesViewController.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 9/27/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit

final class FavoritesViewController: PTViewController {
    
    var tableView: UITableView!
    var tableViewModel: ArticleViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let fvm = tableViewModel else {
            return 1
        }
        
        return fvm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableCell.description(), for: indexPath)
        guard let vm = tableViewModel else {
            return cell
        }
        
        (cell as? FavoritesTableCell)?.cellViewModel = vm[indexPath.row]
        
        cell.backgroundColor = UIColor.white
        
        return cell
    }
}
