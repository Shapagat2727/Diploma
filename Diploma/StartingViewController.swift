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
    var instructors:Results<Instructor>?
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    var found:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
        self.hideKeyboardWhenTappedAround() 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        found = false
        emailTextfield.text = ""
        passwordTextfield.text = ""
    }
    func loadUsers(){
        students = realm.objects(Student.self)
        instructors = realm.objects(Instructor.self)
    }
    func saveStudent(student: Student){
        do{try realm.write{
            realm.add(student)
            }
            
        }catch{
            print("Error saving course, \(error)")
        }
        
    }
    func saveInstructor(instructor: Instructor){
        do{try realm.write{
            realm.add(instructor)
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
                        let beginString = email[..<range.lowerBound]
                        let id = Int(beginString)
                        
                        if (endString == "stu.sdu.edu.kz"){
                            self.checkStudent(with: id!)
                            self.performSegue(withIdentifier: K.loginStudentSegue, sender: self)
                            
    
                        }else if (endString == "sdu.edu.kz"){
                            self.checkInstructor(with: String(beginString))
                            self.performSegue(withIdentifier: K.loginTeacherSegue, sender: self)
                        }else{
                            print("Undefined user")
                        }
                    }
                }
            }
        }
    }
    func checkStudent(with id : Int){
        for student in self.students!{
            if(student.id==id){
                self.found = true
            }
        }
        if(!self.found){
            let newStudent = Student()
            newStudent.firstName = "NAME"
            newStudent.lastName = "SURNAME"
            newStudent.id = id
            self.saveStudent(student: newStudent)
        }
    }
    func checkInstructor(with id : String){
        for instructor in self.instructors!{
            if(instructor.id==id){
                self.found = true
            }
        }
        if(!self.found){
            let newInstructor = Instructor()
            newInstructor.firstName = "NAME"
            newInstructor.lastName = "SURNAME"
            newInstructor.id = id
            self.saveInstructor(instructor: newInstructor)
        }
    }
    
    
    
    
}
