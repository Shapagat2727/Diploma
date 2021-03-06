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
class SignupViewController: UIViewController {
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
        self.hideKeyboardWhenTappedAround()
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
                        let endString = self.email.text![range.upperBound...]
                        if (endString == "stu.sdu.edu.kz"){
                            let id = beginString
                            let newStudent = User()
                            newStudent.firstName = self.firstName.text!
                            newStudent.lastName = self.lastName.text!
                            newStudent.id = String(id)
                            newStudent.status = "student"
                            self.saveUser(user: newStudent)
                        }
                        else if (endString == "sdu.edu.kz"){
                            let newInstructor = User()
                            newInstructor.firstName = self.firstName.text!
                            newInstructor.lastName = self.lastName.text!
                            newInstructor.id = String(beginString)
                            newInstructor.status = "teacher"
                            self.saveUser(user: newInstructor)
                        }
                        else{
                            self.showError(with: "Please enter university email")
                        }
                        
                    }
                    
                }
            }
            
        }
    }
    func saveUser(user: User){
        do{try realm.write{
            realm.add(user)
            }
             showError(with: "Successfully added a new user")
             errorLabel.textColor = UIColor.green
            
        }catch{
            showError(with: "Error saving user data")
        }
        
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
