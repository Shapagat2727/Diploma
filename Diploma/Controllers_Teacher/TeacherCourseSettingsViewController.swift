//
//  TeacherCourseSettingsViewController.swift
//  Diploma
//
//  Created by Шапагат on 4/23/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
class TeacherCourseSettingsViewController: UIViewController {
    let realm = try! Realm()
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var courseField: UITextField!
    var selectedCourse: Course?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        errorLabel.alpha = 0
        if let name = selectedCourse?.name{
            courseField.text = name
        }
        
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func deletePressed(_ sender: UIButton) {
        
        do{
            try realm.write{
                
                for n in 0..<15{
                    realm.delete((selectedCourse?.weeks[n].questions)!)
                }
                realm.delete(selectedCourse!.weeks)
                realm.delete(selectedCourse!)
                dismiss(animated: true, completion: nil)
            }
        }catch{
            print("Error deleting the course, \(error)")
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        do{
            try realm.write{
                if courseField.text != ""{
                    selectedCourse?.name = courseField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                }else{
                    showError(with: "Textfields shouldn't be empty")
                }
            }
        }catch{
            print("Error changing username, \(error)")
        }
    }
    func showError(with message: String){
           errorLabel.text = message
           errorLabel.alpha = 1
       }
    

}
