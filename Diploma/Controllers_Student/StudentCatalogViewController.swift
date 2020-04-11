//
//  CatalogViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/13/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
import Firebase
class StudentCatalogViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var courses:Results<Course>?
    let currentUser = Auth.auth().currentUser!
    var currentStudent:Results<Student>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentStudent = realm.objects(Student.self).filter("id == %@", Int(String((currentUser.email?.prefix(9))!))!)
        loadCourses()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
        
    }
    func loadCourses(){
        courses = realm.objects(Course.self)
        self.tableView.reloadData()
    }
    
    
    
}
//MARK:-TableView DataSource Methods
extension StudentCatalogViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel?.text = courses?[indexPath.row].name ?? "No courses added yet"
        
        if let color = UIColor(hexString: "#214F6F"){
            cell.topicBubble?.backgroundColor = color
            cell.topicLabel?.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        return cell
        
    }
    
    
}
//MARK:-TableView Delegate Methods
extension StudentCatalogViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.largeCell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        registerAlert(with: (courses?[indexPath.row])!)
    }
    func registerAlert(with selectedCourse: Course){
        let alert = UIAlertController(title: selectedCourse.name, message: "Want to register to this course?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Register", style: .default, handler:{ action in
            self.save(course: selectedCourse)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    func save(course: Course){
        if(currentStudent![0].courses.filter("name == '\(course.name)'").count==0){
            do{
                try realm.write{
                    currentStudent![0].courses.append(course)
                }
            }catch{
                print("Error saving course, \(error)")
            }
        }else{
            let alert = UIAlertController(title: course.name, message: "You've already registered to this course", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}


