//
//  Item.swift
//  Todoey
//
//  Created by 성제 on 2022/02/25.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item:Object {
    @objc dynamic var title:String = ""
    @objc dynamic var done:Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
