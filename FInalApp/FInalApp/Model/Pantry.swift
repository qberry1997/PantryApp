//
//  Pantry.swift
//  FInalApp
//
//  Created by Quinn Berry on 11/24/20.
//  Copyright © 2020 Quinn Berry. All rights reserved.
//

import Foundation
import CoreData

class Pantry {
    var fetchedPantryItems:[PantryItem] = []
    let managedObjectContext:NSManagedObjectContext?
    
    // set the current context of the persistant data storage
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    // Return the current amount of PantryItems in the Pantry
    func getCount() -> Int {
        return fetchedPantryItems.count
    }
    
    // Get PantryItem at given index
    func getPantryItemAtIndex(index: Int) -> PantryItem {
        return fetchedPantryItems[index]
    }
    
    // Fetch PantryItem[s] from data storage
    func fetchPantryItems() {
        do {
            self.fetchedPantryItems = try managedObjectContext?.fetch(PantryItem.fetchRequest()) as! [PantryItem]
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    // Save current pantry data storage
    func saveContext() {
        do {
            try self.managedObjectContext!.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    // Add a PantryItem into the data storage
    func addPantryItem(itemName: String){
        let newPantryItem = PantryItem(context: managedObjectContext!)
        newPantryItem.setName(name: itemName)
        
        saveContext()
    }
    
    // Delete PantryItem from the data storage
    func deletePantryItemAtIndex(index: Int) {
        let pantryItemToDelete = self.fetchedPantryItems[index]
        
        self.managedObjectContext?.delete(pantryItemToDelete)
        
        saveContext()
    }
}
