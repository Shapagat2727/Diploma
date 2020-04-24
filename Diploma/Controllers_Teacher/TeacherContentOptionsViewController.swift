//
//  TeacherContentOptionsViewController.swift
//  Diploma
//
//  Created by Шапагат on 4/8/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import ChameleonFramework
class TeacherContentOptionsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var selectedWeek:Week?
    var options = ["Weekly content", "Weekly quiz", "Weekly statistics"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
    }
    
    
    
}


//MARK:-Table View Delegate Methods
extension TeacherContentOptionsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let guide = view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        
        return height/CGFloat(options.count);
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: K.newVideoTextSegue, sender: self)
        case 1:
            performSegue(withIdentifier: K.newContentSegue, sender: self)
        case 2:
            performSegue(withIdentifier: K.statisticsSegue, sender: self)
        default:
            print("Something got wrong")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.newVideoTextSegue{
            let destination = segue.destination as! TeacherVideoTextViewController
            destination.selectedWeek = selectedWeek
            
        }
        if segue.identifier==K.newContentSegue{
            let destination = segue.destination as! TeacherQuizViewController
            destination.selectedWeek = self.selectedWeek
        }
        
        if segue.identifier==K.statisticsSegue{
            let destination = segue.destination as! TeacherStatisticsViewController
            destination.selectedWeek = self.selectedWeek
        }
        
    }
    
}
extension TeacherContentOptionsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel?.text = options[indexPath.row]
        cell.topicBubble!.layer.borderColor = FlatBlueDark().cgColor
        cell.topicBubble!.layer.borderWidth = 3.0
       
        cell.topicBubble!.backgroundColor = FlatWhite()
        return cell
    }
    
    
}

