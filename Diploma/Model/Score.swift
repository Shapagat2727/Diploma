//
//  Score.swift
//  Diploma
//
//  Created by Шапагат on 4/7/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import Foundation
import RealmSwift
class Score: Object {
    @objc dynamic var studentId:String = ""
    @objc dynamic var scoreValue:Int = 0
    var scoreByQuestion = List<Int>()
    var parentWeek = LinkingObjects(fromType: Week.self, property: "scores")
}
