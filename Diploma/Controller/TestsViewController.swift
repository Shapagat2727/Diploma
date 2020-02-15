//
//  TestsViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/13/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit

import ChameleonFramework

class TestsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let testLabelArray = ["Midterm1", "Midterm2", "Final"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
        
    }
}
//MARK:-TableView DataSource Methods
extension TestsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel.text = testLabelArray[indexPath.row]
        if let color = FlatWatermelon().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(testLabelArray.count)){
            cell.topicBubble.backgroundColor = color
            cell.topicLabel.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        return cell
    }
                                   
    
}
//MARK:-TableView Delegate Methods
extension TestsViewController: UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.questionSegue, sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == K.questionSegue{
//            let destination = segue.destination as! QuestionViewController
//
//        }
//    }
}
