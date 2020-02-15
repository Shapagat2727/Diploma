//
//  Question.swift
//  Diploma
//
//  Created by Шапагат on 2/13/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//


import Foundation
struct Question {
    let question: String
    let answers: [String]
    let correct: String
    init(q: String, a: [String], correctAnswer: String) {
        self.question = q
        self.answers = a
        self.correct = correctAnswer
        
    }
}
