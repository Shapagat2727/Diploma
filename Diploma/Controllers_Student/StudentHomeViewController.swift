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
class StudentHomeViewController: UIViewController {
    private let refreshControl = UIRefreshControl()
    let realm = try! Realm()
    var courses:List<Course>?
    @IBOutlet weak var tableView: UITableView!
    let currentUser = Auth.auth().currentUser!
    var currentStudent:Results<User>?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCourses()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        refreshControl.tintColor = UIColor(hexString: "#214F6F")
    }
    func loadCourses(){
        currentStudent = realm.objects(User.self).filter("id == %@", (currentUser.email?.prefix(9))!)
        courses = currentStudent![0].courses
        self.tableView.reloadData()
    }
    @objc private func refreshTable() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        tableView.reloadData()
    }
    
    
    
}
//MARK:-Table View Delegate Methods

extension StudentHomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.largeCell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.studentWeeks, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.studentWeeks{
            let destination = segue.destination as! StudentWeeksViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destination.selectedCourse = courses?[indexPath.row]
            }
        }
    }
    
}

//MARK:-Table View Data Source Mathods
extension StudentHomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses?.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel?.text = courses?[indexPath.row].name ?? "No courses added yet"
        if let color = UIColor(hexString: courses?[indexPath.row].colorCode){
            cell.topicBubble?.backgroundColor = color
            cell.topicLabel?.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        return cell
    }
}
