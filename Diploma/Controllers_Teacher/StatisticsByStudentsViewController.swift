//
//  StatisticsByStudentsViewController.swift
//  Diploma
//
//  Created by Шапагат on 4/9/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit

class StatisticsByStudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        return 240
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedWeek?.scores.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentScore", for: indexPath) as! TableViewCell
        if let score = selectedWeek?.scores[indexPath.row]{
            cell.nameLabel.text = "\(score.studentId)"
            cell.scoreLabel.text = "\(score.scoreValue)"
        }
        return cell
    }
}
