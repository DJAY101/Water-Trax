//
//  HousesViewController.swift
//  Water Trax
//
//  Created by David Jin on 16/10/19.
//  Copyright © 2019 DJAY. All rights reserved.
//

import UIKit
import SwipeCellKit

class HousesTableViewController: UITableViewController{
    
     var houseNameArray = ["House1", "Apartment1"]
     var houseAddressDict = ["House1" : "39 Parkland Avanue", "Apartment1" : "18 George Street"]
     
    override func viewDidLoad() {
        super.viewDidLoad()
        print(houseAddressDict)
        print(houseNameArray[0])
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "adrien-olichon-_VZ2MBS7OvU-unsplash"))
        self.tableView.rowHeight = 85.0


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseNameArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
        //cell.delegate = self
        //  return cell
        // }
        let cell = tableView.dequeueReusableCell(withIdentifier: "HousesCell", for: indexPath) as! SwipeTableViewCell
        
        
        let houseName = houseNameArray[indexPath.row]
        print(indexPath.row)
        cell.textLabel?.text = houseName
        cell.textLabel?.textColor = .systemTeal
        cell.textLabel?.font = .systemFont(ofSize: 25)
        
        cell.detailTextLabel?.text = String(houseAddressDict[houseName]!)
        cell.detailTextLabel?.textColor = .lightGray
        cell.detailTextLabel?.font = .systemFont(ofSize: 15)
        
        cell.delegate = self
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(houseNameArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
  
    }
    @IBAction func plusButtonPressed(_ sender: UIBarButtonItem) {
        promptForNewHouse()
    }
    
    func promptForNewHouse() {
           let AddHouseAlert = UIAlertController(title: "Create New House", message: "This is the name of the house and address", preferredStyle: .alert)
           
               AddHouseAlert.addTextField { (UITextField) in
               UITextField.self.placeholder = "New House Name"
               UITextField.self.keyboardType = .default
               UITextField.self.keyboardAppearance = .dark
                
                AddHouseAlert.addTextField { (UITextField) in
                UITextField.self.placeholder = "Address - Optional"
                UITextField.self.keyboardType = .default
                UITextField.self.keyboardAppearance = .dark
           }

           let continueAction = UIAlertAction(title: "Continue", style: .default) { [unowned AddHouseAlert] _ in
             let name = AddHouseAlert.textFields![0]
            let address = AddHouseAlert.textFields![1]
             print(name.text!)
            self.houseNameArray.append(name.text!)
            self.houseAddressDict[String(name.text!)] = String(address.text!)
            
            self.tableView.reloadData()
            
             
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
            print("Deleted")
            let house = self.houseNameArray[indexPath.row]
            self.houseAddressDict.removeValue(forKey: String(house))
            self.houseNameArray.remove(at: indexPath.row)
            print(self.houseNameArray)
            print(self.houseAddressDict)
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
                       let name = AddHouseAlert.textFields![0]
                       let address = AddHouseAlert.textFields![1]
                       let house = self.houseNameArray[indexPath.row]
                        print(name.text!)
                       
                        
                        if name.text != "" {
                       self.houseNameArray[indexPath.row] = name.text!
                       self.tableView.reloadData()
                        }
                        if address.text != ""  {
                            self.houseAddressDict[String(name.text!)] = String(address.text!)
                            self.houseAddressDict.removeValue(forKey: String(house))
                            
                            self.tableView.reloadData()
                            }
                            else {
                            self.houseAddressDict[name.text!] = self.houseAddressDict[house]
                            self.houseAddressDict.removeValue(forKey: String(house))
                            
                            
                            }

                        
                        
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
