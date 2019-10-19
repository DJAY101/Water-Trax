//
//  User.swift
//  Water Trax
//
//  Created by David Jin on 18/10/19.
//  Copyright © 2019 DJAY. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    @objc dynamic var username = String()
    @objc dynamic var password = String()
    
    let houses = List<House>()
    
}
