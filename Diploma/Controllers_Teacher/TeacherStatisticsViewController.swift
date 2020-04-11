//
//  TeacherStatisticsViewController.swift
//  Diploma
//
//  Created by Шапагат on 4/9/20.
//  Copyright © 2020 Shapagat Bolat. All rights reserved.
//

import UIKit
import ChameleonFramework
class TeacherStatisticsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    var selectedWeek:Week?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var charts = ["PieChart", "ItemAnalysis", "BarChart", "Student list"]
    var chartImages = ["pie-chart", "list", "graph", "book"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: K.pieSegue, sender: self)
        case 1:
            performSegue(withIdentifier: K.analysisSegue, sender: self)
        case 2:
            performSegue(withIdentifier: K.barSegue, sender: self)
        case 3:
            performSegue(withIdentifier: K.studentListSegue, sender: self)
        default:
            print("Something got wrong")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier==K.pieSegue{
            let destination = segue.destination as! PieChartViewController
            
            destination.selectedWeek = selectedWeek
            
        }
        if segue.identifier==K.analysisSegue{
            let destination = segue.destination as! ItemAnalysisViewController
            
            destination.selectedWeek = selectedWeek
            
        }
        if segue.identifier==K.barSegue{
            let destination = segue.destination as! BarChartViewController
            
            destination.selectedWeek = selectedWeek
            
        }
        if segue.identifier==K.studentListSegue{
            let destination = segue.destination as! StudentsListViewController
            
            destination.selectedWeek = selectedWeek
            
        }
    }
    
    
    //MARK:-Layout
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewWidth = collectionView.frame.size.width - padding
        let collectionViewHeight = collectionView.frame.size.height - padding
        
        return CGSize(width: collectionViewWidth/2, height: collectionViewHeight/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
    //MARK:-Delegate and DataSource
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! CollectionViewCell
        cell.cellImageView.image = UIImage(named: chartImages[indexPath.row])
        cell.cellLabel.text = charts[indexPath.row]
        return cell
    }
    
    
}
