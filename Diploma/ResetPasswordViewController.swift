//
//  ResetPasswordViewController.swift
//  Diploma
//
//  Created by Шапагат on 4/25/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import Firebase
class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        let email = emailField.text
        if (email == ""){
            showError(with: "Please, enter your email")
        }else{
            Auth.auth().sendPasswordReset(withEmail: email!) { (error) in
                if error == nil{
                    self.showError(with: "Please check your inbox")
                }else{
                    self.showError(with: error!.localizedDescription)
                }
            }
        }
    }
    func showError(with message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
