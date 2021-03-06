//
//  ViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/12/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class StudentWeeksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    var selectedCourse:Course?
    var weeks:Results<Week>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedCourse?.name
        weeks = selectedCourse?.weeks.sorted(byKeyPath: "id")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        refreshControl.tintColor = UIColor(hexString: "#214F6F")
    }
    @objc private func refreshTable() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}
//MARK:-TableView DataSource Methods
extension StudentWeeksViewController: UITableViewDataSource{
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
//MARK:-TableView Delegate Methods
extension StudentWeeksViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.topicSegue, sender: self)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.mediumCell;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier==K.topicSegue{
            let destination = segue.destination as! StudentTopicViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destination.selectedWeek = weeks?[indexPath.row]
                
            }
            
        }
        
    }
}


