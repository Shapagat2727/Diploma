//
//  ViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/12/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import ChameleonFramework

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    


    let courseTopicsArray = [
        Topic(title: "Topic1", screenshotString: "v1",content:K.loremIpsum),
                             Topic(title: "Topic2", screenshotString: "v2", content:""),
                             Topic(title: "Topic3", screenshotString: "v1", content:""),
                             Topic(title: "Topic4", screenshotString: "v2", content:""),
                             Topic(title: "Topic5", screenshotString: "v1", content:""),
                             Topic(title: "Topic6", screenshotString: "v2", content:""),
                             Topic(title: "Topic7", screenshotString: "v1", content:""),
                             Topic(title: "Topic8", screenshotString: "v2", content:""),
                             Topic(title: "Topic9", screenshotString: "v1", content:""),
                             Topic(title: "Topic10", screenshotString: "v2", content:""),
                             Topic(title: "Topic11", screenshotString: "v1", content:""),
                             Topic(title: "Topic12", screenshotString: "v2", content:""),
                             Topic(title: "Topic13", screenshotString: "v2", content:""),
                             Topic(title: "Topic14", screenshotString: "v2", content:"")]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: K.topicNibName, bundle: nil), forCellReuseIdentifier: K.topicCell)
        
    }
}
//MARK:-TableView DataSource Methods
extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseTopicsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.topicCell, for: indexPath) as! TopicCell
        cell.topicLabel?.text = courseTopicsArray[indexPath.row].title
        if let color = FlatSkyBlue().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(courseTopicsArray.count)){
            cell.topicBubble?.backgroundColor = color
            cell.topicLabel?.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
        }
        return cell
    }
                                   
    
}
//MARK:-TableView Delegate Methods
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.topicSegue, sender: self)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.topicSegue{
            let destination = segue.destination as! TopicViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destination.selectedTopic = courseTopicsArray[indexPath.row]
                 
            }
            
        }
        
    }
}


