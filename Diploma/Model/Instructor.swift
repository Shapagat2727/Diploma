//
//  Instructor.swift
//  Diploma
//
//  Created by Шапагат on 4/4/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import Foundation
import RealmSwift
class Instructor: Object {
    @objc dynamic var id:String = ""
    @objc dynamic var firstName:String = ""
    @objc dynamic var lastName:String = ""
    let courses = List<Course>()
}
