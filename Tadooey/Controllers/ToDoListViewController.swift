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

    var itemArray = [Item]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Bread"
     
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Corn"
        //newItem.done = false
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Peas"
        //newItem.done = false
        itemArray.append(newItem3)
  
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row].title)
        
     
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }

    
    
    
    
    //MARK - add new items -
    
    @IBAction func addButtonIsPressed(_ sender: Any) {
        
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Tadoey item", message: "", preferredStyle: .alert)
        
        
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
        
            
            
        let newItem = Item()
        newItem.title = textField.text!
            
        self.itemArray.append(newItem)
            
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


