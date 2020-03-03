//
//  Week.swift
//  Diploma
//
//  Created by Шапагат on 2/29/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import Foundation
import RealmSwift
import QuizKit
//import AVFoundation

class Week:Object{
    @objc dynamic var id:Int = 0
    @objc dynamic var video:String = "" //---- need to change this
    @objc dynamic var textContent:String = ""
    var parentCourse = LinkingObjects(fromType: Course.self, property: "weeks")
    let questions = List<Question>()
}
