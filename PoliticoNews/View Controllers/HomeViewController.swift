//
//  HomeViewController.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 9/27/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import UIKit
import Alamofire

final class HomeViewController: PTViewController {
    
    let apiToContact = "http://www.politico.com/rss/politicopicks.xml"
    var articles: [Article] = []
    var favorites: [Favorite] = []

    var collectionViewModel: ArticleViewModel?
    var insetHeight: CGFloat?

    let flowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = false

        self.title = "Politico"
        
        getXML(url: apiToContact)
        createCollectionView()
        refreshControl()

    }
    
    fileprivate func refreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
    }

    func refresh(refreshControl: UIRefreshControl) {
        getXML(url: apiToContact)
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    fileprivate func createCollectionView() {
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: "HomeCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .darkGray
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: collectionView.bounds.width/6 + 50, right: 5)

        collectionView.addToAndConstrain(insideSuper: view)
    }
    
    fileprivate func getXML(url: String) {
        
        Alamofire.request(apiToContact).validate().response { response in
        
            guard let data = response.data else {
                return
            }
            
            try? self.articles = ArticleSerialization.articles(data: data)
            
            self.collectionViewModel = self.articles.map({(parameter: Article) -> ArticleViewCellViewModel in
                return ArticleViewCellViewModel(withArticle: parameter)
                })
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let displayVC = DisplayViewController()
        
        displayVC.viewModel = ArticleViewCellViewModel(withArticle: articles[indexPath.row])
        navigationController?.pushViewController(displayVC, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell

        guard let vm = collectionViewModel else {
            return cell
        }
        
        cell.cellViewModel = vm[indexPath.row]
        cell.articleImageView.image = #imageLiteral(resourceName: "temp")
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.bounds.width)
        let itemSize = CGSize(width: itemWidth, height: collectionView.bounds.width/1.88)
        return itemSize
    }
}




