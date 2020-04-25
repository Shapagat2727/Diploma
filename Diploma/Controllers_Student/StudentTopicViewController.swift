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
import Firebase
class StudentTopicViewController: UIViewController {
    let realm = try! Realm()
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var topicScreenshot: UIImageView!
    @IBOutlet weak var topicContent: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    let currentUser = Auth.auth().currentUser!
    var passedAlready:Bool = false
    var selectedWeek:Week?
    var score:Int = 0
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadQuiz()
        loadVideo()
        loadUI()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if let range = currentUser.email?.range(of: "@") {
            let beginString = currentUser.email?[..<range.lowerBound]
            for i in 0..<realm.objects(Score.self).count{
                if(realm.objects(Score.self)[i].studentId == String(beginString!)){
                    passedAlready = true
                    score = realm.objects(Score.self)[i].scoreValue
                }
            }
            
        }
    }
    @IBAction func testButtonPressed(_ sender: UIButton) {
        if selectedWeek!.isReady{
            if passedAlready{
                let alert = UIAlertController(title: "You've already passed this test", message: "Your score is \(score) points out of 10", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }else{
                if selectedWeek?.questions.count == 10{
                    performSegue(withIdentifier: K.weekQuesionSegue, sender: self)
                    
                    
                }else{
                    print("Not enough questions")
                }
            }
        }else{
            let alert = UIAlertController(title: "Quiz isn't set yet", message: "Wait till instructor, adds a quiz", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.weekQuesionSegue{
            let destination = segue.destination as! StudentQuizViewController
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
        
        QKSession.default.limit = 10
        var jsonArray:[Dictionary<String, Any>] = []
     
        
        if (selectedWeek?.questions.count == 10){
            for n in 0...9{ 
                let question = selectedWeek?.questions[n].toDictionary()
                let array = Array(selectedWeek?.questions[n].toDictionary()["responses"] as! List<String>)
                var jsonObject: [String: Any] = [:]
                jsonObject["question"] = "\(question!["question"]!)"
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





