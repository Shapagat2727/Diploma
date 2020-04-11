//
//  StudentsListViewController.swift
//  Diploma
//
//  Created by Шапагат on 4/9/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import RealmSwift
class StudentsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let realm = try! Realm()
    @IBOutlet weak var tableView: UITableView!
    var selectedWeek:Week?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 164
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedWeek?.scores.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentScore", for: indexPath) as! TableViewCell
        if let score = selectedWeek?.scores[indexPath.row]{
            let student = realm.objects(Student.self).sorted(byKeyPath: "id", ascending: true).filter("id == \(score.studentId)")[0]
            cell.idLabel.text = "\(score.studentId)"
            cell.nameLabel.text = student.firstName
            cell.surnameLabel.text = student.lastName
            cell.scoreLabel.text = "\(score.scoreValue)"
        }
        return cell
    }
}
