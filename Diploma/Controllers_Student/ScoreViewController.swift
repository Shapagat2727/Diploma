//
//  ScoreViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/17/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    var totalScore:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(totalScore)"
        
    }

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
}
