//
//  Course.swift
//  Diploma
//
//  Created by Шапагат on 2/29/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import Foundation
import RealmSwift
import ChameleonFramework
class Course:Object {
    @objc dynamic var name:String = ""
    @objc dynamic var id:Int = 0
    @objc dynamic var colorCode:String = ""
    let weeks = List<Week>()
    var parentStudent = LinkingObjects(fromType: User.self, property: "courses")
}


