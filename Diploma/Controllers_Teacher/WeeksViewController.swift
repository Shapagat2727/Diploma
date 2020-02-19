//
//  WeeksViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/19/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import ChameleonFramework

class WeeksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var weeks = ["Week1", "Week2", "Week3", "Week4", "Week5", "Week6", "Week7", "Week8", "Week9", "Week10", "Week11", "Week12", "Week13","Week14", "Week15"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
    }

}
extension WeeksViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120;
    }
}
extension WeeksViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weeks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel.text = weeks[indexPath.row]
        if let color = FlatGray().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(weeks.count)){
            cell.topicBubble.backgroundColor = color
            cell.topicLabel.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        return cell
    }
    
    
}

