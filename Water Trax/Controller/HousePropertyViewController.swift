//
//  HousePropertyViewController.swift
//  Water Trax
//
//  Created by David Jin on 18/10/19.
//  Copyright © 2019 DJAY. All rights reserved.
//

import UIKit

class HousePropertyViewController: UIViewController {
    var text:String = ""
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         textLabel?.text = text

        // Do any additional setup after loading the view.
    }
    




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
