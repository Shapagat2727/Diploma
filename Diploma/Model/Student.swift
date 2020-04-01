//
//  Student.swift
//  Diploma
//
//  Created by Шапагат on 4/1/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import Foundation
import RealmSwift
class Student: Object {
    
    @objc dynamic var id:Int = 0
    @objc dynamic var firstName:String = ""
    @objc dynamic var lastName:String = ""
    let courses = List<Course>()

}
