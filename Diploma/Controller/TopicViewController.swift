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
class TopicViewController: UIViewController {
    
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var topicScreenshot: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var topicContent: UILabel!
    var selectedTopic:Topic?
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuiz()
        self.title = selectedTopic!.title
        topicContent.text = selectedTopic?.content
        topicScreenshot.layer.cornerRadius = 15
        topicScreenshot.image = UIImage(named: selectedTopic!.screenshotString)
        topicScreenshot.isUserInteractionEnabled = true
        testButton.backgroundColor = FlatSkyBlue()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        topicScreenshot.addGestureRecognizer(tapRecognizer)
        
    }
    @objc func playVideo() {
        if let videoPath = Bundle.main.path(forResource: selectedTopic!.screenshotString, ofType: "mp4"){
            let videoPathURL = URL(fileURLWithPath: videoPath)
            player = AVPlayer(url: videoPathURL)
            playerViewController.player = player
            self.present(playerViewController, animated: true, completion:{
                self.playerViewController.player?.play()
            })
        }
        
    }
    func loadQuiz() {
        guard let path = Bundle.main.path(forResource: "quiz", ofType: "json") else {
            return
        }
        
        QKSession.default.limit = 10
        
        if let quiz = QKQuiz(loadFromJSONFile: path) {
            QKSession.default.load(quiz: quiz)
        }
    }
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.weekQuesionSegue, sender: self)
        
        do {
            try QKSession.default.start()
        } catch {
            fatalError("Quiz started without quiz set on the session")
        }
    }

}
