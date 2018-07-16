//
//  ViewController.swift
//  Todoey
//
//  Created by Emma Whan on 15/7/18.
//  Copyright © 2018 Emma Whan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Poosky", "Buy Eggs", "Write will"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
        
    //MARK - Tableview Datasource methods
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text  = itemArray[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
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
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
       
        alert.addAction(action)
        present(alert, animated: true)
    }
}

