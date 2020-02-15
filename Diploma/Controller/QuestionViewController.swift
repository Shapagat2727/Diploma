//
//  QuestionViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/13/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

       @IBOutlet weak var questionLabel: UILabel!
       @IBOutlet weak var firstOption: UIButton!
       @IBOutlet weak var secondOption: UIButton!
       @IBOutlet weak var thirdOption: UIButton!
       @IBOutlet weak var progressBar: UIProgressView!
       @IBOutlet weak var scoreLabel: UILabel!
       
       var quizBrain = QuizBrain()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           updateUI()
       }
       
       @IBAction func answerButtonPressed(_ sender: UIButton) {
           
           let userAnswer = sender.currentTitle!
           
           if(quizBrain.checkAnswer(userAnswer)){
               sender.backgroundColor = UIColor.green
           }
           else{
               sender.backgroundColor = UIColor.red
           }
           
           quizBrain.changeQuestion()
           
           Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
           
       }
       
       @objc func updateUI(){
           
           progressBar.progress = quizBrain.getPercentage()
           questionLabel.text = quizBrain.getCurrentQuestion()
           scoreLabel.text = "Score: \(quizBrain.getScore())"
           firstOption.setTitle(quizBrain.getAnswers()[0], for: .normal)
           secondOption.setTitle(quizBrain.getAnswers()[1], for: .normal)
           thirdOption.setTitle(quizBrain.getAnswers()[2], for: .normal)
           firstOption.backgroundColor = UIColor.clear
           secondOption.backgroundColor = UIColor.clear
           thirdOption.backgroundColor = UIColor.clear
           
       }

}
