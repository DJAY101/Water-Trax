//
//  HousesViewController.swift
//  Water Trax
//
//  Created by David Jin on 16/10/19.
//  Copyright © 2019 DJAY. All rights reserved.
//

import UIKit
import SwipeCellKit
import RealmSwift

class HousesTableViewController: UITableViewController{
     var houseArray: Results<House>?
     let realm = try! Realm()
     var test101 = String()
    var selectedUser : User? {
        didSet{
            loadHouses()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "adrien-olichon-_VZ2MBS7OvU-unsplash"))
        self.tableView.rowHeight = 85.0
        print(test101)
        loadHouses()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
        //cell.delegate = self
        //  return cell
        // }
        let cell = tableView.dequeueReusableCell(withIdentifier: "HousesCell", for: indexPath) as! SwipeTableViewCell
        
        if let House = houseArray?[indexPath.row] {
            cell.textLabel?.text = House.houseName
            cell.textLabel?.textColor = .systemTeal
            cell.textLabel?.font = .systemFont(ofSize: 25)
    
            cell.detailTextLabel?.text = House.houseAddress
            cell.detailTextLabel?.textColor = .lightGray
            cell.detailTextLabel?.font = .systemFont(ofSize: 15)
        } else {
            cell.textLabel?.text = "No House Added"
            cell.textLabel?.textColor = .systemTeal
            cell.textLabel?.font = .systemFont(ofSize: 25)
    
        }
        cell.delegate = self
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Houses", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.performSegue(withIdentifier: "goToProperty", sender: self)
  
    }
    @IBAction func plusButtonPressed(_ sender: UIBarButtonItem) {
        promptForNewHouse()
    }
    
    
    
    
    func loadHouses() {
        //todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        houseArray = selectedUser?.houses.sorted(byKeyPath: "houseName", ascending: true)
    
        tableView.reloadData()
        
    }
    func save(house : House) {
           do {
               try realm.write {
                selectedUser?.houses.append(house)
               }
           } catch {
               print("Error saving house \(error)")
           }
           
           tableView.reloadData()
           
       }
    
    
    func promptForNewHouse() {
           let AddHouseAlert = UIAlertController(title: "Create New House", message: "This is the name of the house and address", preferredStyle: .alert)
           
               AddHouseAlert.addTextField { (UITextField) in
               UITextField.self.placeholder = "New House Name*"
               UITextField.self.keyboardType = .default
               UITextField.self.keyboardAppearance = .dark
                
                AddHouseAlert.addTextField { (UITextField) in
                UITextField.self.placeholder = "Address - Optional"
                UITextField.self.keyboardType = .default
                UITextField.self.keyboardAppearance = .dark
           }

           let continueAction = UIAlertAction(title: "Continue", style: .default) { [unowned AddHouseAlert] _ in
            
            if AddHouseAlert.textFields![0].text! != ""{
            let name = AddHouseAlert.textFields![0].text!
            let address = AddHouseAlert.textFields![1].text!
            let newHouse = House()
                newHouse.houseAddress = address
                newHouse.houseName = name
            
            self.save(house: newHouse)
            self.tableView.reloadData()
            } else {
                self.promptForNewHouse()
            }
            
             
           }
           let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [] _ in

           }
               
           AddHouseAlert.addAction(cancelAction)
           AddHouseAlert.addAction(continueAction)
            self.present(AddHouseAlert, animated: true)
       }
    }
    
 }

extension HousesTableViewController : SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            if let houseForDeletion = self.houseArray?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(houseForDeletion)
                    }
                } catch {
                    print("Error deleting category, \(error)")
                }
            }
            print("Deleted")
            
        }
        let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
            // handle action by updating model with deletion
            let AddHouseAlert = UIAlertController(title: "Edit", message: "Edit your house name and address", preferredStyle: .alert)
                      
                AddHouseAlert.addTextField { (UITextField) in
                UITextField.self.placeholder = "House Name"
                UITextField.self.keyboardType = .default
                UITextField.self.keyboardAppearance = .dark
                           
                AddHouseAlert.addTextField { (UITextField) in
                UITextField.self.placeholder = "Address"
                UITextField.self.keyboardType = .default
                UITextField.self.keyboardAppearance = .dark
                }

                let continueAction = UIAlertAction(title: "Save", style: .default) { [unowned AddHouseAlert] _ in
                let name = AddHouseAlert.textFields![0].text!
                let address = AddHouseAlert.textFields![1].text!
                       
                        
                    if name != "" {
                        
                        if let House = self.houseArray?[indexPath.row] {
                            
                            
                            do {
                                try self.realm.write {
                                    House.houseName = name
                                }
                            } catch {
                                print("Error saving done status, \(error)")
                            }
                            
                        }
                        
                        
                    }
                    if address != "" {
                        if let House = self.houseArray?[indexPath.row] {
                            
                            
                            do {
                                try self.realm.write {
                                    House.houseAddress = address
                                }
                            } catch {
                                print("Error editing house address, \(error)")
                            }
                            
                        }
                        
                    }
                    self.tableView.reloadData()
                        
                }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [] _ in

        }
                          
        AddHouseAlert.addAction(cancelAction)
        AddHouseAlert.addAction(continueAction)
        self.present(AddHouseAlert, animated: true)
        }
               
               
        print("Edited")
        
            
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "Trash-Icon")
        editAction.image = UIImage(named: "Edit-Icon")
        

        return [deleteAction, editAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}
