//
//  ViewController.swift
//  Todoey
//
//  Created by Emma Whan on 15/7/18.
//  Copyright © 2018 Emma Whan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Poosky"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy cat food"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Pat Poosky"
        itemArray.append(newItem3)
        
        //if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        //itemArray = items}
    }
        
    //MARK - Tableview Datasource methods
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text  = item.title
        cell.accessoryType = item.done ? .checkmark : .none
     
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
         var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when user clicks add item on alert
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
       
        alert.addAction(action)
        present(alert, animated: true)
    }
}

