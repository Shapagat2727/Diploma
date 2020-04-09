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
    @IBOutlet weak var checkButtonA: UIButton!
    @IBOutlet weak var checkButtonB: UIButton!
    @IBOutlet weak var checkButtonC: UIButton!
    @IBOutlet weak var checkButtonD: UIButton!
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
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        questionView.backgroundColor = FlatGreen()
        do{
            try realm.write{
                selectedWeek?.questions[index!].category = "Category_Name"
                selectedWeek?.questions[index!].question = questionTitle.text!
                selectedWeek?.questions[index!].responses[0] = variantA.text!
                selectedWeek?.questions[index!].responses[1] = variantB.text!
                selectedWeek?.questions[index!].responses[2] = variantC.text!
                selectedWeek?.questions[index!].responses[3] = variantD.text!
                selectedWeek?.questions[index!].correct_response = correctResponseIndex
                selectedWeek?.questions[index!].type = "multiple_choice"
                
            }
        }catch{
            print("error  saving question \(error)")
        }
        
        
    }
    
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        checkButtonA.tintColor = FlatGray()
        checkButtonB.tintColor = FlatGray()
        checkButtonC.tintColor = FlatGray()
        checkButtonD.tintColor = FlatGray()
        sender.tintColor = FlatGreen()
        self.correctResponseIndex = sender.tag
        
        
    }
    
    
}
