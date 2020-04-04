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

class CatalogViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var courses:Results<Course>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
extension CatalogViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel?.text = courses?[indexPath.row].name ?? "No courses added yet"
        
        if let color = FlatWatermelon().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(courses?.count ?? 1)){
            cell.topicBubble?.backgroundColor = color
            cell.topicLabel?.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        return cell
        
    }
    
    
}
//MARK:-TableView Delegate Methods
extension CatalogViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.largeCell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        registerAlert(with: courses?[indexPath.row].name ?? "Course Name")
    }
    func registerAlert(with selectedCourse: String){
        let alert = UIAlertController(title: selectedCourse, message: "Want to register to this course?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Register", style: .default, handler:nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

