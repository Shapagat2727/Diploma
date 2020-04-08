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
    var questions:[Dictionary<String, Any>] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = loadQuiz()
        self.hideKeyboardWhenTappedAround()
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.newQuestionNibName, bundle: nil), forCellReuseIdentifier: K.newQuestionCell)
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide( note:NSNotification )
    {
        // read the CGRect from the notification (if any)
        
            let insets = UIEdgeInsets( top: 0, left: 0, bottom: 0, right: 0 )
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
        
    }
    @objc func keyboardWillShow( note:NSNotification )
    {
        // read the CGRect from the notification (if any)
        if let newFrame = (note.userInfo?[ UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue)?.cgRectValue {
            let insets = UIEdgeInsets( top: 0, left: 0, bottom: newFrame.height, right: 0 )
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
        }
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
        
        cell.index = indexPath.row
        cell.selectedWeek = self.selectedWeek
        return cell
    }
    
    
    
}



