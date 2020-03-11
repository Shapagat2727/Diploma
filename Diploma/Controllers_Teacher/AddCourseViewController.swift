//
//  AddCourseViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/19/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import ChameleonFramework
import RealmSwift
class AddCourseViewController: UIViewController {
    let realm = try! Realm()
    @IBOutlet weak var tableView: UITableView!
    var courses:Results<Course>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCourses()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField:UITextField?
        let alert = UIAlertController(title: "Add new course", message: "", preferredStyle:.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let text = textField?.text{
                if !text.isEmpty{
                    let newCourse = Course()
                    newCourse.name = text
                    self.save(course: newCourse)
                }
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "type here..."
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    func save(course: Course){
        do{
            try realm.write{
                for n in 0...14{
                    let week = Week()
                    week.id = n
                    course.weeks.append(week)
                }
                realm.add(course)
            }
        }catch{
            print("Error saving course, \(error)")
        }
        self.tableView.reloadData()
    }
    func loadCourses(){
        courses = realm.objects(Course.self)
        self.tableView.reloadData()
    }
    
}


//MARK:-Table View Delegate Methods

extension AddCourseViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.largeCell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.weeksSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.weeksSegue{
            let destination = segue.destination as! WeeksViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destination.selectedCourse = courses?[indexPath.row]
            }
        }
    }
    
}

//MARK:-Table View Data Source Mathods
extension AddCourseViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses?.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel?.text = courses?[indexPath.row].name ?? "No courses added yet"
        let color = RandomFlatColor()
        cell.topicBubble?.backgroundColor = color
        cell.topicLabel?.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        
        return cell
    }
    
}
