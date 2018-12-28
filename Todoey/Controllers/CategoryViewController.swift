//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Emma Whan on 28/7/18.
//  Copyright © 2018 Emma Whan. All rights reserved.
//

import UIKit
import RealmSwift
//configure migration - needs to be done in first view controller to launch
//let config = Realm.Configuration(
//    // Set the new schema version. This must be greater than the previously used
//    // version (if you've never set a schema version before, the version is 0).
//    schemaVersion: 1,
//
//    // Set the block which will be called automatically when opening a Realm with
//    // a schema version lower than the one set above
//    migrationBlock: { migration, oldSchemaVersion in
//        // We haven’t migrated anything yet, so oldSchemaVersion == 0
//        if (oldSchemaVersion < 1) {
//            // Nothing to do!
//            // Realm will automatically detect new properties and removed properties
//            // And will update the schema on disk automatically
//        } else {
//            //do nothing
//        }
//})


class CategoryViewController: UITableViewController {

  let realm = try! Realm()
    
    //use following line of code if we need o do a migration
    //lazy var realm = try! Realm(configuration: config)
    
    //print(Realm.Configuration.defaultConfiguration.fileURL)
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text  = categories?[indexPath.row].name ?? "No categories added yet"
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen when user clicks add item on alert
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category:newCategory)
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    //MARK: Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    //MARK: Data Manipulation Methods
    func loadCategories() {
       categories  = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    func save(category:Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print ("Error saving data \(error)")
        }
        tableView.reloadData()
    }
}
