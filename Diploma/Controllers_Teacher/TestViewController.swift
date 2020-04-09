//
//  TestViewController.swift
//  Diploma
//
//  Created by Шапагат on 2/28/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import Charts
import Realm
import ChameleonFramework
class TestViewController: UIViewController {
    var performanceRates: [String]!
    var performanceRatesShort: [String]!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var viewBubble: UIView!
    var selectedWeek:Week?
    override func viewDidLoad() {
        super.viewDidLoad()
        performanceRates = ["Far Below Basic", "Below Basic", "Basic", "Above Basic", "Advanced"]
        performanceRatesShort = ["FBB", "BB", "B", "AB", "A"]
        let numberOfStudentsPerRate = calculateRates()
        
        setChart(labels: performanceRatesShort, values: numberOfStudentsPerRate)
        
        viewBubble.layer.borderColor = FlatRed().cgColor
        viewBubble.layer.borderWidth = 3.0
        viewBubble.layer.cornerRadius = pieChart.frame.size.height / 30
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
    func calculateRates()->[Double]{
        var rates:[Double] = [0,0,0,0,0]
        for n in 0..<(selectedWeek?.scores.count)!{
            if let num = selectedWeek?.scores[n].scoreValue{
                switch num{
                case 0..<2:
                    rates[0] += 1
                case 2..<4:
                    rates[1] += 1
                case 4..<6:
                    rates[2] += 1
                case 6..<8:
                    rates[3] += 1
                case 8...10:
                    rates[4] += 1
                default:
                    break
                }
            }
            
        }
        return rates
    }
}

