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
class TopicViewController: UIViewController {

    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var topicScreenshot: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    var selectedTopic:Topic?
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedTopic!.title
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
    

    @IBAction func testButtonPressed(_ sender: UIButton) {
    }
    
}
