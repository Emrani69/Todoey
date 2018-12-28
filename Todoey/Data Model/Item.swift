//
//  Item.swift
//  Todoey
//
//  Created by Emma Whan on 18/8/18.
//  Copyright © 2018 Emma Whan. All rights reserved.
//

import Foundation
import RealmSwift

class Item:Object {
    
    //version 0
    @objc dynamic var title:String = ""
    @objc dynamic var done:Bool = false
    
    //version 1
    @objc dynamic var dateCreated:Date = Date()
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
