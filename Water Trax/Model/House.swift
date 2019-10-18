//
//  House.swift
//  Water Trax
//
//  Created by David Jin on 17/10/19.
//  Copyright © 2019 DJAY. All rights reserved.
//

import Foundation

class House {
    var houseName : String
    var houseAddress : String
    
    func changeHouseName (newHouseName : String) {
        houseName = newHouseName
    }
    
    func changeHouseAddress(newAddress : String) {
        houseAddress = newAddress
    }
    
    init(name : String, address : String) {
        houseName = name
        houseAddress = address
    }
    
    
}
