//
//  CoreDataHelper.swift
//  PoliticoNews
//
//  Created by Chris Chueh on 10/2/17.
//  Copyright © 2017 Chris Chueh. All rights reserved.
//

import CoreData
import UIKit

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    //static methods will go here
    
    static func newFavorite() -> Favorite {
        let favorite = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: managedContext) as! Favorite
        
        return favorite
    }
    
    static func saveFavorite() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func delete(favorite: Favorite) {
        managedContext.delete(favorite)
        saveFavorite()
    }
    
    static func retrieveFavorites() -> [Favorite] {
        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }
}
