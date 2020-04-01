//
//  ViewController.swift
//  Diploma
//
//  Created by Шапагат on 3/28/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import Firebase
class StartingViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let e = error{
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    
                    if let range = email.range(of: "@") {
                        let endString = email[range.upperBound...]
                        if (endString == "stu.sdu.edu.kz"){
                            self.performSegue(withIdentifier: K.loginStudentSegue, sender: self)
                        }else if (endString == "sdu.edu.kz"){
                            self.performSegue(withIdentifier: K.loginTeacherSegue, sender: self)
                        }else{
                            print("Undefined user")
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    
    
}
