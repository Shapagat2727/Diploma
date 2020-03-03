//
//  TopicCell.swift
//  Diploma
//
//  Created by Шапагат on 2/13/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet weak var topicBubble: UIView?
    @IBOutlet weak var topicLabel: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        topicBubble?.layer.cornerRadius = (topicBubble?.frame.size.height ?? 50) / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
