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
class TopicViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var topicScreenshot: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var topicContent: UILabel!
    var selectedTopic:Week?
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuiz()
        self.title = "Week\(selectedTopic!.id+1)"
        topicContent.text = selectedTopic?.textContent
        topicScreenshot.layer.cornerRadius = 15
        topicScreenshot.image = UIImage(named: "v1")
        topicScreenshot.isUserInteractionEnabled = true
        testButton.backgroundColor = FlatSkyBlue()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        topicScreenshot.addGestureRecognizer(tapRecognizer)
        
    }
    @objc func playVideo() {
        if let videoPath = Bundle.main.path(forResource: selectedTopic!.video, ofType: "mp4"){
            let videoPathURL = URL(fileURLWithPath: videoPath)
            player = AVPlayer(url: videoPathURL)
            playerViewController.player = player
            self.present(playerViewController, animated: true, completion:{
                self.playerViewController.player?.play()
            })
        }
        
    }
    func loadQuiz() {
        let videoString = selectedTopic?.video ?? "no video found"
        
        if let range = videoString.range(of: "v=") {
            let videoCode = videoString[range.upperBound...]
            getVideo(videoCode:String(videoCode))
        }
        
        guard let path = Bundle.main.path(forResource: "quiz", ofType: "json") else {
            return
        }
        
        QKSession.default.limit = 10
        
        if let quiz = QKQuiz(loadFromJSONFile: path) {
            QKSession.default.load(quiz: quiz)
            //let jsonString = try? String(contentsOfFile: path)
            //print(jsonString)
            //print(path)
            
        }
        
        //        let jsonString = selectedTopic?.toDictionary()
        //        if let quiz = QKQuiz(loadFromJSONString: "\(String(describing: jsonString))") {
        //            QKSession.default.load(quiz: quiz)
        //        }
    }
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.weekQuesionSegue, sender: self)
        
        do {
            try QKSession.default.start()
        } catch {
            fatalError("Quiz started without quiz set on the session")
        }
    }
    func getVideo(videoCode:String){
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        webView.load(URLRequest(url:url!)) //check if valid url then
    }
    
}


//extension Object {
//    func toDictionary() -> NSDictionary {
//        let properties = self.objectSchema.properties.map { $0.name }
//        let dictionary = self.dictionaryWithValues(forKeys: properties)
//
//        let mutabledic = NSMutableDictionary()
//        mutabledic.setValuesForKeys(dictionary)
//
//        for prop in (self.objectSchema.properties as [Property]?)! {
//            if prop.objectClassName != nil  {
//                if let nestedObject = self[prop.name] as? Object {
//                    mutabledic.setValue(nestedObject.toDictionary(), forKey: prop.name)
//                } else if let nestedListObject = self[prop.name] as? ListBase {
//                    var objects = [AnyObject]()
//                    for index in 0..<nestedListObject._rlmArray.count  {
//                        if let object = nestedListObject._rlmArray[index] as? Object {
//                            objects.append(object.toDictionary())
//                        }
//                    }
//                    mutabledic.setObject(objects, forKey: prop.name as NSCopying)
//                }
//            }
//        }
//        return mutabledic
//    }
//}
