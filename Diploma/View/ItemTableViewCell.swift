//
//  ItemTableViewCell.swift
//  Diploma
//
//  Created by Шапагат on 2/28/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import Charts
import ChameleonFramework
class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemConteiner: UIView!
    @IBOutlet weak var itemBubble:BarChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        itemConteiner.layer.borderColor = FlatGray().cgColor
        itemConteiner.layer.borderWidth = 3.0
        itemConteiner.layer.cornerRadius = itemConteiner.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
