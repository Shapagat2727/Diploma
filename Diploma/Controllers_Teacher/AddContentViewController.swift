//
//  AddContentViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/20/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import RealmSwift
class AddContentViewController: UIViewController {
    var questions = ["Question1", "Question2", "Question3", "Question4", "Question5", "Question6", "Question7", "Question8", "Question9", "Question10", "Question11", "Question12", "Question13","Question14", "Question15"]
    var selectedWeek:Week?
    @IBOutlet weak var tableView: UITableView!
    var selectedIndex = -1
    var isCollapsed = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.newQuestionNibName, bundle: nil), forCellReuseIdentifier: K.newQuestionCell)
    }
    
}

//MARK:-Table View Delegate Methods
extension AddContentViewController: UITableViewDelegate{
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if selectedIndex == indexPath.row && isCollapsed{
//            return K.largeCell
//        }else{
//            return K.mediumCell
//        }
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedIndex == indexPath.row{
            isCollapsed = !isCollapsed
        }else{
            isCollapsed = true
        }
        selectedIndex = indexPath.row
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}

//MARK:-Table View Data Source Methods
extension AddContentViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.newQuestionCell, for: indexPath) as! ExpandableTableViewCell
        cell.questionLabel.text = questions[indexPath.row]
//        cell.questionView.frame.size.height = 20
        cell.index = indexPath.row
        cell.selectedWeek = self.selectedWeek
        return cell
    }
    
    
}
