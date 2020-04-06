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
    @objc dynamic var category:String = ""
    @objc dynamic var type:String = ""
    @objc dynamic var correct_response:Int = 0
    let responses = List<String>()
    var parentWeek = LinkingObjects(fromType: Week.self, property: "questions")
}




//{
//    "question": "What is the range of short data type in Java??",
//    "category": "Java",
//    "type": "multiple_choice",
//    "correct_response": 1,
//    "responses": [
//        "-128 to 127",
//        "-32768 to 32767",
//        "-2147483648 to 2147483647"
//    ]
//}
