//
//  TeacherHomeViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/19/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//
 
import UIKit
import ChameleonFramework
import RealmSwift
import Firebase
class TeacherHomeViewController: UIViewController {
    private let refreshControl = UIRefreshControl()
    let realm = try! Realm()
    @IBOutlet weak var tableView: UITableView!
    var courses:List<Course>?
    let currentUser = Auth.auth().currentUser!
    var currentInstrucor:Results<User>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCourses()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
        
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        refreshControl.tintColor = UIColor(hexString: "#214F6F")
        
    }
    
    @objc private func refreshTable() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField:UITextField?
        let alert = UIAlertController(title: "Add new course", message: "", preferredStyle:.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let text = textField?.text{
                if !text.isEmpty{
                    let newCourse = Course()
                   
                    newCourse.name = text
                    newCourse.colorCode = RandomFlatColor().hexValue()
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
        if(realm.objects(Course.self).filter("name == '\(course.name)'").count==0){
            do{
                try realm.write{
                    for n in 0...14{
                        let week = Week()
                        week.id = n
                        for _ in 0...9{
                            let newQuestion = Question()
                            newQuestion.question = ""
                            newQuestion.responses.append(objectsIn: ["","","",""])
                            newQuestion.correct_response = 0
                            newQuestion.scoreByAnswer.append(objectsIn: [0,0,0,0])
                            week.questions.append(newQuestion)
                        }
                        course.weeks.append(week)
                    }
                    currentInstrucor![0].courses.append(course)
                }
            }catch{
                print("Error saving course, \(error)")
            }
            
        }else{
            let alert = UIAlertController(title: course.name, message: "This course name is taken, try another one", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        self.tableView.reloadData()
    }
    func loadCourses(){
        if let range = currentUser.email?.range(of: "@") {
            let beginString = currentUser.email?[..<range.lowerBound]
            currentInstrucor = realm.objects(User.self).filter("id == %@", String(beginString!))
            
            courses = currentInstrucor![0].courses
            self.tableView.reloadData()
        }
        
    }
    
}


//MARK:-Table View Delegate Methods

extension TeacherHomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.largeCell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.weeksSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.weeksSegue{
            let destination = segue.destination as! TeacherWeeksViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destination.selectedCourse = courses?[indexPath.row]
            }
        }
    }
    
}

//MARK:-Table View Data Source Mathods
extension TeacherHomeViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses?.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel?.text = courses?[indexPath.row].name ?? "No courses added yet"
        
        if let color = UIColor(hexString:courses?[indexPath.row].colorCode){
            cell.topicBubble?.backgroundColor = color
            cell.topicLabel?.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        
        
        return cell
    }
    
}
