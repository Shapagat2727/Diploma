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
class StartingViewController: UIViewController {
    let realm = try! Realm()
    var students:Results<Student>?
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    var found:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStudents()
    }
    func loadStudents(){
        students = realm.objects(Student.self)
    }
    func save(student: Student){
        do{try realm.write{
            realm.add(student)
            }
            
        }catch{
            print("Error saving course, \(error)")
        }
        
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
                        let id = Int(String(email.prefix(9)))
                        
                        if (endString == "stu.sdu.edu.kz"){
                            
                            self.performSegue(withIdentifier: K.loginStudentSegue, sender: self)
                            for student in self.students!{
                                if(student.id==id){
                                    self.found = true
                                }
                            }
                            if(!self.found){
                                let newStudent = Student()
                                newStudent.firstName = "NAME"
                                newStudent.lastName = "SURNAME"
                                newStudent.id = id!
                                self.save(student: newStudent)
                            }
                            
                            
                            
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
