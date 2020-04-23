//
//  TeacherAccountSettingsViewController.swift
//  Diploma
//
//  Created by Шапагат on 4/23/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
class TeacherAccountSettingsViewController: UIViewController {
    let realm = try! Realm()
    let currentFirebaseUser = Auth.auth().currentUser!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    var currentUser: Results<User>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        if let range = currentFirebaseUser.email?.range(of: "@") {
            let beginString = currentFirebaseUser.email?[..<range.lowerBound]
            currentUser = realm.objects(User.self).filter("id == %@", String(beginString!))
        }
        if let user = currentUser?.first{
            firstNameField.text = user.firstName
            lastNameField.text = user.lastName
        }
        
    }
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        do{
            try realm.write{
                if firstNameField.text != "" && lastNameField.text != ""{
                    currentUser?.first?.firstName = firstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    currentUser?.first?.lastName = lastNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                }else{
                    showError(with: "Textfields shouldn't be empty")
                }
            }
        }catch{
            print("Error changing username, \(error)")
        }
    }
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    func showError(with message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
}
