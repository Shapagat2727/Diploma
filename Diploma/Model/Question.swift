//
//  Question.swift
//  Diploma
//
//  Created by Шапагат on 3/1/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import Foundation
import RealmSwift
class Question: Object {
   
    @objc dynamic var question:String = ""
    @objc dynamic var correct_response:Int = 0
    var scoreByAnswer = List<Int>()
    let responses = List<String>()
    var parentWeek = LinkingObjects(fromType: Week.self, property: "questions")
    @objc dynamic var isValid:Bool = false
}

