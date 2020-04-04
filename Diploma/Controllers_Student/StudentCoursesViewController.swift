//
//  studentCoursesViewController.swift
//  Diploma
//
//  Created by Шапагат on 3/3/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import ChameleonFramework
import RealmSwift
import Firebase
class StudentCoursesViewController: UIViewController {
    
    let realm = try! Realm()
    var courses:List<Course>?
    @IBOutlet weak var tableView: UITableView!
    let currentUser = Auth.auth().currentUser!
    var currentStudent:Results<Student>?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCourses()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
    }
    func loadCourses(){
        currentStudent = realm.objects(Student.self).filter("id == %@", Int(String((currentUser.email?.prefix(9))!))!)
        courses = currentStudent![0].courses
        self.tableView.reloadData()
    }
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
          let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
}
//MARK:-Table View Delegate Methods

extension StudentCoursesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.largeCell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.studentWeeks, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.studentWeeks{
            let destination = segue.destination as! HomeViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destination.selectedCourse = courses?[indexPath.row]
            }
        }
    }
    
}

//MARK:-Table View Data Source Mathods
extension StudentCoursesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses?.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel?.text = courses?[indexPath.row].name ?? "No courses added yet"
        if let color = FlatSkyBlue().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(courses?.count ?? 1)){
            cell.topicBubble?.backgroundColor = color
            cell.topicLabel?.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        return cell
    }
}
