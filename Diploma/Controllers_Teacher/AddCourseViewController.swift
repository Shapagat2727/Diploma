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
    var courses:[Course] = [Course(name: "Algorithms", id: 0, weeks: K.weeks),
                            Course(name: "Mathematics", id: 1, weeks: K.weeks),
                            Course(name: "Digital design", id: 2, weeks: K.weeks)]
    
    
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
                    self.courses.append(Course(name: text, id: self.courses.count, weeks: []))
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
        return K.largeCell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.weeksSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.weeksSegue{
            let destination = segue.destination as! WeeksViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destination.selectedCourse = courses[indexPath.row]
            }
        }
    }
    
}

//MARK:-Table View Data Source Mathods
extension AddCourseViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel.text = courses[indexPath.row].name
        if let color = FlatMint().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(courses.count)){
            cell.topicBubble.backgroundColor = color
            cell.topicLabel.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        return cell
    }
    
}
