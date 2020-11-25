//
//  TableViewController.swift
//  FInalApp
//
//  Created by Quinn Berry on 11/24/20.
//  Copyright © 2020 Quinn Berry. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var pantryTable: UITableView!
    
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pantry:Pantry?

    override func viewDidLoad() {
        super.viewDidLoad()

        pantry = Pantry(context: manageObjectContext)
        pantry?.fetchPantryItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.pantryTable.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pantry!.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! PantryTableViewCell
        cell.layer.borderWidth = 1.0
        
        let pantryItem = pantry?.getPantryItemAtIndex(index: indexPath.row)
        
        cell.itemName.text = pantryItem!.getName()
        cell.itemDiff.text = (String)((pantryItem?.getThreshold())! - (pantryItem?.getCurrent())!)
        
        if let image = pantryItem?.getImage() {
            cell.itemImage.image = UIImage(data: image)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Delete the PantryItem from the data storage
        pantry?.deletePantryItemAtIndex(index: indexPath.row)
        // Reload data from storage
        pantry?.fetchPantryItems()
        // Reload table
        self.pantryTable.reloadData()
        
    }
    @IBAction func addPantryItem(_ sender: Any) {
        let alert = UIAlertController(title: "Add Item", message: "What is the item called?", preferredStyle: .alert)
        
        alert.addTextField()
        
        let submit = UIAlertAction(title: "OK", style: .default, handler: {(action) in
            
            let nameTextField = alert.textFields![0]
            
            self.pantry?.addPantryItem(itemName: nameTextField.text!)
            
            self.pantry?.fetchPantryItems()
            
            self.pantryTable.reloadData()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        })
        
        alert.addAction(submit)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}
