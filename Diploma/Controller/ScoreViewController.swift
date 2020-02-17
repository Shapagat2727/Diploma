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

}
