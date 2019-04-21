//
//  ViewController.swift
//  Tadooey
//
//  Created by Kegan Ronholt on 4/2/19.
//  Copyright © 2019 Kegan Ronholt. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var defaults = UserDefaults.standard

    var itemArray = ["Tomatoes", "Eggs", "Peppers"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

    
    
    
    
    //MARK - add new items -
    
    @IBAction func addButtonIsPressed(_ sender: Any) {
        
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Tadoey item", message: "", preferredStyle: .alert)
        
        
    
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
        
        self.itemArray.append(textField.text ?? "New item")
            
        self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            
        self.tableView.reloadData()
        
        //print(textField.text)
        }
    
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            
            }
        
        present(alert, animated: true, completion: nil)
    
    
        }
    
}//end of controller


