//
//  SegmentedViewController.swift
//  Diploma
//
//  Created by Шапагат on 4/8/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit

class SegmentedViewController: UIViewController {
    
    
    var simpleView1: UIView!
    var simpleView2: UIView!
    @IBOutlet weak var viewContainer: UIView!
    @IBAction func switchVew(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            //viewContainer.bringSubviewToFront(simpleView1)
            viewContainer.subviews[1].alpha = 0
            viewContainer.subviews[0].alpha = 1
        case 1:
            viewContainer.subviews[0].alpha = 0
            viewContainer.subviews[1].alpha = 1
            //viewContainer.bringSubviewToFront(simpleView2)
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        simpleView1 = SimpleViewOneViewController().view
        simpleView2 = SimpleViewTwoViewController().view
        viewContainer.addSubview(simpleView1)
        viewContainer.addSubview(simpleView2)
        viewContainer.subviews[1].alpha = 0
        viewContainer.subviews[0].alpha = 1
    }
    
    
    
}
