//
//  RegistrationViewController.swift
//  Diploma
//
//  Created by Шапагат on 4/7/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
class RegistrationViewController: UIViewController {
    let realm = try! Realm()
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatedPassword: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        let error = validateFields()
        if(error != nil){
            showError(with: error!)
        }else{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
                if error != nil{
                    self.showError(with: "Error creating user")
                }else{
                    if let range = self.email.text!.range(of: "@") {
                        let beginString = self.email.text![..<range.lowerBound]
                        let id = Int(beginString)
                        let newStudent = Student()
                        newStudent.firstName = self.firstName.text!
                        newStudent.lastName = self.lastName.text!
                        newStudent.id = id!
                        self.saveStudent(student: newStudent)
                    }
                    
                }
            }
        }
    }
    func saveStudent(student: Student){
        do{try realm.write{
            realm.add(student)
            }
            
        }catch{
            showError(with: "Error saving user data")
        }
       showError(with: "Successfully added user")
        
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields()->String?{
        
        if(firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""||lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""||email.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""||password.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""||repeatedPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
            return "Please fill in all fields"
        }
        
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(!isPasswordValid(cleanedPassword)){
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        if(password.text != repeatedPassword.text){
            return "Please make sure you correctly repeated password"
        }
        
        return nil
    }
    func setUpElements(){
        errorLabel.alpha = 0
    }
    
    func showError(with message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
