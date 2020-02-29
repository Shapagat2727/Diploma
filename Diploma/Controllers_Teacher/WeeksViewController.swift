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
    var selectedCourse:Course?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedCourse?.name
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
    }

}
//MARK:-Table View Delegate Methods
extension WeeksViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.mediumCell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.newVideoTextSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.newVideoTextSegue{
            let destination = segue.destination as! AddVideoTextViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destination.selectedWeek = selectedCourse?.weeks[indexPath.row]
            }
        }
    }
    
}
//MARK:-Table View Data Source Methods
extension WeeksViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCourse?.weeks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel.text = "Week \((selectedCourse?.weeks[indexPath.row].id)! + 1)"
        if let value = self.selectedCourse?.weeks.count{
            if let color = FlatGray().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(value)){
                cell.topicBubble.backgroundColor = color
                cell.topicLabel.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
            }
        }
        
        return cell
    }
    
    
}

