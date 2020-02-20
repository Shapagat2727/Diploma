//
//  ExpandableTableViewCell.swift
//  Diploma
//
//  Created by Шапагат on 2/20/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import ChameleonFramework
import QuizKit
class ExpandableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionTitle: UITextField!
    @IBOutlet weak var variantA: UITextField!
    @IBOutlet weak var variantB: UITextField!
    @IBOutlet weak var variantC: UITextField!
    @IBOutlet weak var variantD: UITextField!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionView.layer.cornerRadius = questionView.frame.size.height / 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        //newQuestion?.question = questionTitle.text!
        
    }
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        print(sender.tag)
        if (sender.tintColor == FlatGreen()){
            sender.tintColor = FlatGray()
        }else{
            sender.tintColor = FlatGreen()
        }
    }
    
}
