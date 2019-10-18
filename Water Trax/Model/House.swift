//
//  House.swift
//  Water Trax
//
//  Created by David Jin on 17/10/19.
//  Copyright © 2019 DJAY. All rights reserved.
//

import Foundation
import RealmSwift
class House: Object {
    @objc dynamic var houseName : String = ""
    @objc dynamic var houseAddress : String = ""
    @objc dynamic var data: HouseData?
}
