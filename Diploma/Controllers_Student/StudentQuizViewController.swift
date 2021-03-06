//
//  QuestionViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/13/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import QuizKit
import RealmSwift
import Firebase
class StudentQuizViewController: UIViewController {
    let realm = try! Realm()
    let currentUser = Auth.auth().currentUser!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var firstCheck: UIButton!
    @IBOutlet weak var secondCheck: UIButton!
    @IBOutlet weak var thirdCheck: UIButton!
    @IBOutlet weak var fourthCheck: UIButton!
    
    var selectedWeek:Week?
    var session = QKSession.default
    var question:QKQuestion?
    var response:String?
    var indexOfQuession: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        indexOfQuession = 0
        do {
            
            try session.start()
            saveInitialScore()
        } catch {
            fatalError("Quiz started without quiz set on the session")
        }
        updateUI()
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        closeAlert()
    }
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        updatePress(with: sender)
    }
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        updatePress(with: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.scoreSegue{
            let destination = segue.destination as! StudentScoreViewController
            destination.totalScore = self.session.score
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if (response == ""){
            nextAlert()
        }else{
            session.submit(response: response!, for: question!)
            
            changeScore(with: response == question?.correctResponse, and:(question?.responses.firstIndex(of: response!))!, at: (selectedWeek?.questions[indexOfQuession!])!)
            if(session.nextQuestion(after: question) == nil){
                
                performSegue(withIdentifier: K.scoreSegue, sender: self)
            }else{
                updateUI()
            }
        }
        indexOfQuession! += 1
    }
    func saveInitialScore(){
        if let range = currentUser.email?.range(of: "@") {
            let beginString = currentUser.email?[..<range.lowerBound]
            let id = String(beginString!)
            let score = Score()
            score.studentId = id
            score.scoreValue = 0
            
            
            do{try realm.write{
                selectedWeek?.scores.append(score)
                }
                
            }catch{
                print("Error saving course, \(error)")
            }
        }
        
        
    }
    
    func changeScore(with isCorrect: Bool, and variant: Int, at ques: Question){
        if let range = currentUser.email?.range(of: "@") {
            let beginString = currentUser.email?[..<range.lowerBound]
            let id = String(beginString!)
                do{try realm.write{
                    if(isCorrect){
                        
                        selectedWeek?.scores.filter("studentId == '\(id)'")[0].scoreValue += 1
                        selectedWeek?.scores.filter("studentId == '\(id)'")[0].scoreByQuestion.append(1)
                    }else{
                        selectedWeek?.scores.filter("studentId == '\(id)'")[0].scoreByQuestion.append(0)
                    }
                    ques.scoreByAnswer[variant] += 1
                    
                    }
                    
                }catch{
                    print("Error saving course, \(error)")
                }
            
            
            
        }
    }
    
    
    //MARK:- Custom Functions
    func nextAlert(){
        let alert = UIAlertController(title: "Can't go further", message: "Please choose a variant to continue", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    func closeAlert(){
        let alert = UIAlertController(title: "Are you sure?", message: "You can choose to complete the quiz immediately. You results will be nullified.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler:{ action in
            
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    func updateUI(){
        DispatchQueue.main.async {
            self.deselectButtons()
        }
        if let nextQuestion = session.nextQuestion(after: question){
            question = nextQuestion
            response = ""
            questionLabel.text = question?.question
            progressBar.progress = session.progress(for:question!)
            
            firstOption.setTitle(question!.responses[0], for: .normal)
            secondOption.setTitle(question!.responses[1], for: .normal)
            thirdOption.setTitle(question!.responses[2], for: .normal)
            fourthOption.setTitle(question!.responses[3], for: .normal)
            
        }
    }
    
    func updatePress(with sender: UIButton){
        DispatchQueue.main.async {
            self.deselectButtons()
            switch sender.tag{
            case 0:
                self.response = self.firstOption.currentTitle
                self.firstCheck.isSelected = true
            case 1:
                self.response = self.secondOption.currentTitle
                self.secondCheck.isSelected = true
            case 2:
                self.response = self.thirdOption.currentTitle
                self.thirdCheck.isSelected = true
            case 3:
                self.response = self.fourthOption.currentTitle
                self.fourthCheck.isSelected = true
            default:
                break
            }
        }
    }
    func deselectButtons(){
        self.firstCheck.isSelected = false
        self.secondCheck.isSelected = false
        self.thirdCheck.isSelected = false
        self.fourthCheck.isSelected = false
    }
}

