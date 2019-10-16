//
//  HousesViewController.swift
//  Water Trax
//
//  Created by David Jin on 16/10/19.
//  Copyright © 2019 DJAY. All rights reserved.
//

import UIKit

class HousesTableViewController: UITableViewController {
    
     var houseNameArray = ["House1", "Apartment1"]
     var houseAddressDict = ["House1" : "39 Parkland Avanue", "Apartment1" : "18 George Street"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(houseAddressDict)
        print(houseNameArray[0])
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "adrien-olichon-_VZ2MBS7OvU-unsplash"))


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseNameArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "MyTestCell")
        
        
        let houseName = houseNameArray[indexPath.row]
        cell.textLabel?.text = houseName
        cell.textLabel?.textColor = .systemTeal
        cell.textLabel?.font = .systemFont(ofSize: 25)
        
        cell.detailTextLabel?.text = String(houseAddressDict[houseName]!)
        cell.detailTextLabel?.textColor = .lightGray
        cell.detailTextLabel?.font = .systemFont(ofSize: 15)
        
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
                UITextField.self.placeholder = "Address"
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
