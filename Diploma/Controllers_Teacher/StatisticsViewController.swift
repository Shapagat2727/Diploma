//
//  StatisticsViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/23/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import Charts
import ChameleonFramework
class StatisticsViewController: UIViewController {
    var months: [String]!
    var selectedWeek:Week?
    @IBOutlet weak var barChartView:BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        let unitsPositive = [91.0, 27.0, 0.0, 9.0, 64.0, 18.0, 0.0, 64.0, 82.0, 64.0, 18.0, 0.0]
        let unitsNegative = [-9.0, -73.0, -100.0, -91.0, -36.0, -82.0, -100.0, -36.0, -18.0, -36.0, -82.0, -100.0]
                
        setChart(dataPoints: months, positive: unitsPositive, negative: unitsNegative)
    }
    

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    func setChart(dataPoints: [String], positive: [Double], negative: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
                
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [positive[i], negative[i]])
            dataEntries.append(dataEntry)
        }
                
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Units Sold")
        chartDataSet.colors =  [FlatGreen(), FlatPink()]
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        barChartView.xAxis.granularityEnabled = true

    }
    
   
    


}
