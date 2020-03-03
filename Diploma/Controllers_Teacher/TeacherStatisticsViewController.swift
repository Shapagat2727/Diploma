//
//  TeacherStatisticsViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/29/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import ChameleonFramework
class TeacherStatisticsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var charts = ["PieChart", "ItemAnalysis", "BarChart"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
        
    }
    
}
//MARK:-Table View Delegate Methods
extension TeacherStatisticsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: K.pieSegue, sender: self)
        case 1:
            performSegue(withIdentifier: K.analysisSegue, sender: self)
        case 2:
            performSegue(withIdentifier: K.barSegue, sender: self)
        default:
            print("Something got wrong")
        }
    }
    
}
extension TeacherStatisticsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel?.text = charts[indexPath.row]
        if let color = FlatGreen().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(charts.count)){
            cell.topicBubble?.backgroundColor = color
            cell.topicLabel?.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        return cell
    }
    
    
}
