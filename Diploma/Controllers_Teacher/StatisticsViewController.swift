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
    
    var selectedWeek:Week?
    var questionNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var positiveCounter:[Int] = [0,0,0,0,0,0,0,0,0,0]
    var negativeCounter:[Int] = [0,0,0,0,0,0,0,0,0,0]
    
    @IBOutlet weak var barChartView:BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePositiveNegative()
        let unitsPositive = calculatePercentage(with: positiveCounter, value: true)
        let unitsNegative = calculatePercentage(with: negativeCounter, value: false)
        setChart(dataPoints: questionNumbers, positive: unitsPositive, negative: unitsNegative)
    }
    
    func calculatePositiveNegative(){
        for n in 0..<(selectedWeek?.scores.count)!{
            for i in 0..<(selectedWeek?.scores[n].scoreByQuestion.count)!{
                if let isCorrect = (selectedWeek?.scores[n].scoreByQuestion[i]){
                    if(isCorrect == 0){
                        negativeCounter[i] += 1
                    }else{
                        positiveCounter[i] += 1
                    }
                }
            }
        }
    }
    
    func calculatePercentage(with counter: [Int], value: Bool)->[Double]{
        var results:[Double] = []
        for count in counter{
            let percent = (count * 100) / (selectedWeek?.scores.count)!
            if(value){
                results.append(Double(percent))
            }else{
                results.append(Double(0 - percent))
            }
        }
        return results
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
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: questionNumbers)
        barChartView.xAxis.granularityEnabled = true
        
    }
  
}
