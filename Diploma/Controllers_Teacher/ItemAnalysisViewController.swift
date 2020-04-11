//
//  ItemAnalysisViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/28/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import Charts
import ChameleonFramework
class ItemAnalysisViewController: UIViewController {
    var variants = ["A", "B", "C", "D"]
    @IBOutlet weak var tableView: UITableView!
    var selectedWeek:Week?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.itemNibName, bundle: nil), forCellReuseIdentifier: K.itemAnalysisCell)
    }
    
    
}

//MARK:-TableView Delegate Methods
extension ItemAnalysisViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300;
    }
}

//MARK:-TableView DataSource Methods
extension ItemAnalysisViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedWeek?.questions.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.itemAnalysisCell, for: indexPath) as! ItemTableViewCell
        cell.itemBubble.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
       
        for i in 0..<variants.count {
            let dataEntry = BarChartDataEntry(x:Double(i), y: Double((selectedWeek?.questions[indexPath.row].scoreByAnswer[i])!), data: "hey")
            
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Number of students by answers - Question #\(indexPath.row + 1)")
       
        chartDataSet.colors = [FlatWatermelon(), FlatWatermelon(),FlatWatermelon(), FlatWatermelon()]
        chartDataSet.colors[(selectedWeek?.questions[indexPath.row].correct_response)!] = FlatGreen()
        let chartData = BarChartData(dataSet: chartDataSet)
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .decimal
        chartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        cell.itemBubble.xAxis.valueFormatter = IndexAxisValueFormatter(values: variants)
        cell.itemBubble.xAxis.granularityEnabled = true
        cell.itemBubble.xAxis.labelPosition = .bottom
        cell.itemBubble.data = chartData
        cell.itemBubble.xAxis.drawGridLinesEnabled = false
        cell.itemBubble.leftAxis.enabled = false
        cell.itemBubble.rightAxis.enabled = false

        return cell
    }
    
    
}



