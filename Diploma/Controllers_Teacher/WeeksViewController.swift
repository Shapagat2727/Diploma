//
//  WeeksViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/19/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import ChameleonFramework
import RealmSwift

class WeeksViewController: UIViewController {
    let realm = try! Realm()
    @IBOutlet weak var tableView: UITableView!
    var weeks:Results<Week>?
    var selectedCourse:Course?{
        didSet{
            
            loadWeeks()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadWeeks()
        self.title = selectedCourse?.name
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
        
    }
    func loadWeeks(){
        weeks = selectedCourse?.weeks.sorted(byKeyPath: "id")
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
        
    }
}
//MARK:-Table View Delegate Methods
extension WeeksViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.mediumCell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.optionsSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.optionsSegue{
            let destination = segue.destination as! ThreeOptionsViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destination.selectedWeek = weeks?[indexPath.row]
            }
        }
    }
    
}
//MARK:-Table View Data Source Methods
extension WeeksViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeks?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        if let week = weeks?[indexPath.row]{
            cell.topicLabel?.text = "Week \(week.id + 1)"
        }else{
            cell.topicLabel?.text = "No weeks found yet"
        }
        
        if let color = UIColor(hexString: selectedCourse?.colorCode).darken(byPercentage: CGFloat(indexPath.row)/CGFloat(weeks?.count ?? 1)){
            cell.topicBubble?.backgroundColor = color
            cell.topicLabel?.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        
        
        
        return cell
    }
    
    
}

