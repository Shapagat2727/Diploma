//
//  AddContentViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/20/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class AddContentViewController: UIViewController {
    let realm = try! Realm()
    var selectedWeek:Week?
    @IBOutlet weak var tableView: UITableView!
    var selectedIndex = -1
    //    var isCollapsed = false
    var questions:[Dictionary<String, Any>] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = loadQuiz()
        //tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.newQuestionNibName, bundle: nil), forCellReuseIdentifier: K.newQuestionCell)
    }
    
    
    
    @IBAction func addQuestionPressed(_ sender: UIBarButtonItem) {
        let newQuestion = Question()
        newQuestion.category = "Category_Name"
        newQuestion.question = ""
        newQuestion.responses.append(objectsIn: ["","","",""])
        newQuestion.correct_response = 0
        newQuestion.type = "multiple_choice"
        
        do{
            try realm.write{
                selectedWeek?.questions.append(newQuestion)
            }
        }catch{
            print("error  saving question \(error)")
        }
        questions = loadQuiz()
        self.tableView.reloadData()
    }
    func loadQuiz()->[Dictionary<String, Any>] {
        
        var jsonArray:[Dictionary<String, Any>] = []
        
        if ((selectedWeek?.questions.count)!>0){
            for n in 0...(selectedWeek?.questions.count)!-1{
                let question = selectedWeek?.questions[n].toDictionary()
                let array = Array(selectedWeek?.questions[n].toDictionary()["responses"] as! List<String>)
                var jsonObject: [String: Any] = [:]
                jsonObject["question"] = "\(question!["question"]!)"
                jsonObject["category"] =  "\(question!["category"]!)"
                jsonObject["type"] =  "\(question!["type"]!)"
                jsonObject["correct_response"] = question!["correct_response"]!
                jsonObject["responses"] = array
                jsonArray.append(jsonObject)
            }
        }
        return jsonArray
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}

//MARK:-Table View Delegate Methods
//extension AddContentViewController: UITableViewDelegate{
//
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            if selectedIndex == indexPath.row && isCollapsed{
//                return K.largeCell
//            }else{
//                return K.mediumCell
//            }
//        }
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            tableView.deselectRow(at: indexPath, animated: true)
//            if selectedIndex == indexPath.row{
//                isCollapsed = !isCollapsed
//            }else{
//                isCollapsed = true
//            }
//            selectedIndex = indexPath.row
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        }
//
//}

//MARK:-Table View Data Source Methods
extension AddContentViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.newQuestionCell, for: indexPath) as! ExpandableTableViewCell
        cell.questionLabel.text = "Question \(indexPath.row + 1)"
        cell.questionTitle.text = questions[indexPath.row]["question"] as? String
        if let array = questions[indexPath.row]["responses"] as? [String]{
            cell.variantA.text = array[0]
            cell.variantB.text = array[1]
            cell.variantC.text = array[2]
            cell.variantD.text = array[3]
        }
      
        //        cell.questionView.frame.size.height = 20
        cell.index = indexPath.row
        cell.selectedWeek = self.selectedWeek
        return cell
    }
    
    
    
}



