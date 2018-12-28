//
//  Category.swift
//  Todoey
//
//  Created by Emma Whan on 18/8/18.
//  Copyright © 2018 Emma Whan. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name:String = ""
    let items = List<Item>()
}
