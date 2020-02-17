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
    
    var session = QKSession.default
    var question:QKQuestion?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        session.submit(response: sender.currentTitle!, for: question!)
        if(session.nextQuestion(after: question) == nil){
            performSegue(withIdentifier: K.scoreSegue, sender: self)
        }else{
            updateUI()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.scoreSegue{
            let destination = segue.destination as! ScoreViewController
            destination.totalScore = self.session.score
        }
    }
    
    @objc func updateUI(){
        
        scoreLabel.text = "Score: \(session.score)"
        if let nextQuestion = session.nextQuestion(after: question){
            
            question = nextQuestion
            print(question?.type)
            questionLabel.text = question?.question
            progressBar.progress = session.progress(for:question!)
            firstOption.setTitle(question!.responses[0], for: .normal)
            secondOption.setTitle(question!.responses[1], for: .normal)
            thirdOption.setTitle(question!.responses[2], for: .normal)
        }
    }
}
