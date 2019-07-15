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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
   
     
        loadItem()
        
        
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
        
        saveItem()
    }

    
    
    
    
    //MARK - add new items -
    
    @IBAction func addButtonIsPressed(_ sender: Any) {
        
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Tadoey item", message: "", preferredStyle: .alert)
        
        
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
        
            
            
        let newItem = Item()
        newItem.title = textField.text!
            
        self.itemArray.append(newItem)
            
        self.saveItem()
        
        //print(textField.text)
        }
    
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            
            }
        
        present(alert, animated: true, completion: nil)
    
    
        }
    
    func saveItem(){
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
            
            
            
        } catch{
            print("Error encoding item array \(error)")
        }
        
        // self.defaults.set(self.itemArray, forKey: "TodoListArray")
        
        
        self.tableView.reloadData()
        
        
    }
    
    func loadItem(){
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            
            }catch{
                print("Error occured in decoding \(error)")
            }
        }
    }
    
}//end of controller


