//
//  AddCourseViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/19/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import ChameleonFramework
class AddCourseViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var courses:[String] = ["Algorithms", "Software Eng", "Mathematics"]
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    self.courses.append(text)
                    self.tableView.reloadData()
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
    
}


//MARK:-Table View Delegate Methods

extension AddCourseViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.weeksSegue, sender: self)
    }
    
}

//MARK:-Table View Data Source Mathods
extension AddCourseViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel.text = courses[indexPath.row]
        if let color = FlatGray().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(courses.count)){
            cell.topicBubble.backgroundColor = color
            cell.topicLabel.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        return cell
    }
    
    
}
