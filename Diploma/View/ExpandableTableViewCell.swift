//
//  ExpandableTableViewCell.swift
//  Diploma
//
//  Created by Шапагат on 2/20/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import ChameleonFramework
import QuizKit
import RealmSwift
class ExpandableTableViewCell: UITableViewCell {
    var correctResponseIndex = 0
    let realm = try! Realm()
    var selectedWeek:Week?
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionTitle: UITextField!
    @IBOutlet weak var variantA: UITextField!
    @IBOutlet weak var variantB: UITextField!
    @IBOutlet weak var variantC: UITextField!
    @IBOutlet weak var variantD: UITextField!
    var index: Int?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = questionView.frame.size.height / 5
        self.layer.borderColor = FlatGray().cgColor
        self.layer.borderWidth = 3.0
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        questionView.backgroundColor = FlatGreen()
        //newQuestion?.question = questionTitle.text!
//        print(questionTitle.text!)
//        print(variantA.text!)
//        print(variantB.text!)
//        print(variantC.text!)
//        print(variantD.text!)
//        print(index!)
//        print(selectedWeek)
        let newQuestion = Question()
        newQuestion.category = "Category_Name"
        newQuestion.question = questionTitle.text!
        newQuestion.responses.append(objectsIn: [variantA.text!,
                                                 variantB.text!,
                                                 variantC.text!,
                                                 variantD.text!])
        newQuestion.correct_response = correctResponseIndex
        newQuestion.type = "multiple_choice"
        do{
            try realm.write{
                selectedWeek?.questions.append(newQuestion)
            }
        }catch{
            print("error  saving question \(error)")
        }
        
        
    }

    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        print(sender.tag)
        if (sender.tintColor == FlatGreen()){
            sender.tintColor = FlatGray()
        }else{
            sender.tintColor = FlatGreen()
            self.correctResponseIndex = sender.tag
            
        }
    }
    
}
