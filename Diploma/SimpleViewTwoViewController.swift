//
//  SimpleViewTwoViewController.swift
//  Diploma
//
//  Created by Шапагат on 4/8/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import Charts
import ChameleonFramework
class SimpleViewTwoViewController: UIViewController {
    var performanceRatesShort: [String]!
    var performanceRates: [String]!

    @IBOutlet weak var pieChart: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        performanceRates = ["Far Below Basic", "Below Basic", "Basic", "Above Basic", "Advanced"]
        performanceRatesShort = ["FBB", "BB", "B", "AB", "A"]
        let numberOfStudentsPerRate = [14.0, 5.0, 13.0, 7.0, 3.0]
        
        setChart(labels: performanceRatesShort, values: numberOfStudentsPerRate)
    }
    func setChart(labels: [String], values: [Double]) {
        pieChart.noDataText = "You need to provide data for the chart."
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<labels.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: labels[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "Score Chart - Exam #1")
        let colors = [FlatRed(), FlatOrange(), FlatYellow(), FlatGreen(), FlatGreenDark()]
        chartDataSet.colors = colors
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChart.data = chartData
    }


    

}




