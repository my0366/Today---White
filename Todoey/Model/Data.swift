//
//  Data.swift
//  Todoey
//
//  Created by 성제 on 2022/02/25.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Data:Object {
    @objc dynamic var name:String = ""
    @objc dynamic var age:Int = 0
}
