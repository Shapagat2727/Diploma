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
    let weeks = List<Week>()
    var parentStudent = LinkingObjects(fromType: Student.self, property: "courses")
}


