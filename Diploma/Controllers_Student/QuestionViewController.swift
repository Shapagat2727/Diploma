//
//  QuestionViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/13/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import QuizKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var firstCheck: UIButton!
    @IBOutlet weak var secondCheck: UIButton!
    @IBOutlet weak var thirdCheck: UIButton!
    
    @IBOutlet weak var questionImageView: UIImageView!
    
    var session = QKSession.default
    var question:QKQuestion?
    var response:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try QKSession.default.start()
        } catch {
            fatalError("Quiz started without quiz set on the session")
        }
        updateUI()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        updatePress(with: sender)
    }
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        updatePress(with: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.scoreSegue{
            let destination = segue.destination as! ScoreViewController
            destination.totalScore = self.session.score
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        session.submit(response: response!, for: question!)
        //updateUI()
        if(session.nextQuestion(after: question) == nil){
            performSegue(withIdentifier: K.scoreSegue, sender: self)
        }else{
            updateUI()
        }
    }
    @objc func updateUI(){
        DispatchQueue.main.async {
            self.firstCheck.isSelected = false
            self.secondCheck.isSelected = false
            self.thirdCheck.isSelected = false
        }
        scoreLabel.text = "Score: \(session.score)"

        if let nextQuestion = session.nextQuestion(after: question){

            question = nextQuestion

            questionLabel.text = question?.question
            progressBar.progress = session.progress(for:question!)
            if(question?.type == QuizKit.QKQuestionType.imageChoice){
                let image1 = UIImage(named: (question?.responses[0])!) as UIImage?
                let image2 = UIImage(named: (question?.responses[1])!) as UIImage?
                let image3 = UIImage(named: (question?.responses[2])!) as UIImage?
                firstOption.setImage(image1, for: .normal)
                secondOption.setImage(image2, for: .normal)
                thirdOption.setImage(image3, for: .normal)
                firstOption.setTitle("", for: .normal)
                secondOption.setTitle("", for: .normal)
                thirdOption.setTitle("", for: .normal)
            }
            else if (question?.type == QuizKit.QKQuestionType.multipleChoice){
                firstOption.setImage(nil, for: .normal)
                secondOption.setImage(nil, for: .normal)
                thirdOption.setImage(nil, for: .normal)
                firstOption.setTitle(question!.responses[0], for: .normal)
                secondOption.setTitle(question!.responses[1], for: .normal)
                thirdOption.setTitle(question!.responses[2], for: .normal)
            }
        }
    }
    
    func updatePress(with sender: UIButton){
        DispatchQueue.main.async {
            if (sender == self.firstCheck || sender == self.firstOption){
                self.response = self.firstOption.currentTitle
                self.firstCheck.isSelected = true
                self.secondCheck.isSelected = false
                self.thirdCheck.isSelected = false
            }else if(sender == self.secondCheck || sender == self.secondOption){
                self.response = self.secondOption.currentTitle
                self.secondCheck.isSelected = true
                self.firstCheck.isSelected = false
                self.thirdCheck.isSelected = false
            }else{
                self.response = self.thirdOption.currentTitle
                self.thirdCheck.isSelected = true
                self.firstCheck.isSelected = false
                self.secondCheck.isSelected = false
            }
        }
        
        
    }
}

