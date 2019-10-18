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
     var houseArray = [House]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "adrien-olichon-_VZ2MBS7OvU-unsplash"))
        self.tableView.rowHeight = 85.0
        let newhouse1 = House(name: "House1", address: "39 Parkland Avanue")
        let newhouse2 = House(name: "Apartment1", address: "18 George Street")
        houseArray.append(newhouse1)
        houseArray.append(newhouse2)
    


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
        //cell.delegate = self
        //  return cell
        // }
        let cell = tableView.dequeueReusableCell(withIdentifier: "HousesCell", for: indexPath) as! SwipeTableViewCell
        
        print(indexPath.row)
        let houseName = houseArray[indexPath.row].houseName
        let houseAddress = houseArray[indexPath.row].houseAddress
        print(houseName)
        print(houseAddress)
        print(indexPath.row)
        cell.textLabel?.text = houseName
        cell.textLabel?.textColor = .systemTeal
        cell.textLabel?.font = .systemFont(ofSize: 25)

        cell.detailTextLabel?.text = houseAddress
        cell.detailTextLabel?.textColor = .lightGray
        cell.detailTextLabel?.font = .systemFont(ofSize: 15)
        
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
            let newHouse = House(name: name, address: address)
            self.houseArray.append(newHouse)
            
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
            print("Deleted")
            self.houseArray.remove(at: indexPath.row)
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
                        self.houseArray[indexPath.row].changeHouseName(newHouseName: name)
                        
                    }
                    if address != "" {
                        self.houseArray[indexPath.row].changeHouseAddress(newAddress: address)
                        
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
