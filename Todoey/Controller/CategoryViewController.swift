//
//  CategoryViewController.swift
//  Todoey
//
//  Created by 성제 on 2022/02/23.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var categories : Results<Category>?
    
    
    override func viewDidLoad() {
        loadCategory()
        
        tableView.rowHeight = 80.0
    }
    @IBAction func addButton(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.flatWhite().hexValue()
            self.saveCategory(category: newCategory)
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField.placeholder = "Add New Item"
            textField = field
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name ?? "No Categories Add"
            
            cell.backgroundColor = UIColor(hexString: category.colour ?? "1D9BF6")
            
        }
        
    
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    
    func saveCategory(category : Category) {
        do {
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory() {
        categories = realm.objects(Category.self)
        
        tableView.reloadData()

    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("\(error)")
            }
            
        }
    }
}


