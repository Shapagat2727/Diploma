//
//  ViewController.swift
//  Diploma
//
//  Created by Шапагат on 3/28/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
import SwiftyUserDefaults
class LoginViewController: UIViewController, UITextFieldDelegate {
    let realm = try! Realm()
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        self.hideKeyboardWhenTappedAround()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let UD = UserDefaults.standard

            if (UD.bool(forKey: "isLoggedIn")){

                if (UD.string(forKey: "status")=="student"){
                    self.performSegue(withIdentifier: K.loginStudentSegue, sender: self)
                }
                if (UD.string(forKey: "status")=="teacher"){
                    self.performSegue(withIdentifier: K.loginTeacherSegue, sender: self)
                }
            }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        emailTextfield.text = ""
        passwordTextfield.text = ""
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                
                if let e = error{
                    self.showError(with: e.localizedDescription)
                    
                }else{
                   
                    if let range = email.range(of: "@") {
                        let beginString = email[ ..<range.lowerBound]
                        let user = self.realm.objects(User.self).filter("id == '\(beginString)'")[0]
                        
                        //                   let user = Auth.auth().currentUser
                        //                        user!.reload{(error) in
                        //                            if user!.isEmailVerified{
                        if (user.status == "student"){
                            self.addUserDefaults(with: user)
           
                            self.performSegue(withIdentifier: K.loginStudentSegue, sender: self)
                            
                        }else if (user.status == "teacher"){
                            self.addUserDefaults(with: user)
                          
                            self.performSegue(withIdentifier: K.loginTeacherSegue, sender: self)
                            
                        }else{
                            print("Undefined user")
                        }
                        
                        //                            }else{
                        //                                user?.sendEmailVerification{(error) in
                        //                                    print("\(String(describing: error)) !!!!!!!!!")
                        //                                }
                        //                                print("Verify it now")
                        //                            }
                        //                        }
                        
                        
                    }
                }
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.alpha = 0
    }
    func setUpElements(){
        errorLabel.alpha = 0
    }
    func showError(with message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func addUserDefaults(with user: User){
        UserDefaults.standard.set(true, forKey: "isLoggedIn") //Bool
        UserDefaults.standard.set(user.firstName, forKey: "firstName")  //Integer
        UserDefaults.standard.set(user.lastName, forKey: "lastName")
        UserDefaults.standard.set(user.id, forKey: "id")
        UserDefaults.standard.set(user.status, forKey: "status")
        UserDefaults.standard.synchronize()
    }
    
    
    
}


