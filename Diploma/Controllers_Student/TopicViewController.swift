//
//  TopicViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/12/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import ChameleonFramework
import QuizKit
import RealmSwift
import WebKit
import SwiftyJSON

class TopicViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var topicScreenshot: UIImageView!
    @IBOutlet weak var topicContent: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var selectedWeek:Week?
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuiz()
        loadVideo()
        loadUI()
        
        
    }
    @IBAction func testButtonPressed(_ sender: UIButton) {
        
        if selectedWeek?.questions.count == 10{
            performSegue(withIdentifier: K.weekQuesionSegue, sender: self)
        }else{
            print("Not enough questions")
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.weekQuesionSegue{
            let destination = segue.destination as! QuestionViewController
            destination.selectedWeek = selectedWeek
            
        }
    }
    func loadUI(){
        self.title = "Week\(selectedWeek!.id+1)"
        topicContent.text = selectedWeek?.textContent
        topicScreenshot.layer.cornerRadius = 15
        topicScreenshot.image = UIImage(named: "v1")
        topicScreenshot.isUserInteractionEnabled = true
        testButton.backgroundColor = FlatSkyBlue()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        topicScreenshot.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK:-Video Player Functions
    @objc func playVideo() {
        if let videoPath = Bundle.main.path(forResource: selectedWeek!.video, ofType: "mp4"){
            let videoPathURL = URL(fileURLWithPath: videoPath)
            player = AVPlayer(url: videoPathURL)
            playerViewController.player = player
            self.present(playerViewController, animated: true, completion:{
                self.playerViewController.player?.play()
            })
        }
    }
    func loadVideo(){
        let videoString = selectedWeek?.video ?? "no video found"
        if let range = videoString.range(of: "v=") {
            let videoCode = videoString[range.upperBound...]
            getVideo(videoCode:String(videoCode))
        }
    }
    func getVideo(videoCode:String){
        if let url = URL(string: "https://www.youtube.com/embed/\(videoCode)"){
            webView.load(URLRequest(url:url))
            errorLabel.isHidden = true
        }
    }
    //MARK:- Quiz Functions
    func loadQuiz() {
        
        QKSession.default.limit = 10  //change to 15
        var jsonArray:[Dictionary<String, Any>] = []
        //need to fix if questions are empty
        
        if (selectedWeek?.questions.count == 10){
            for n in 0...9{ //change to 14
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
            let myString = ("\(json(from:jsonArray as Any)!)")
            if let quiz = QKQuiz(loadFromJSONString: myString) {
                QKSession.default.load(quiz: quiz)
            }
        }
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}





