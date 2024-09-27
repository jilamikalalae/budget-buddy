//
//  ReportChartViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 19/9/2567 BE.
//

import UIKit
import DGCharts

class ReportChartViewController: UIViewController {
    
    
    @IBOutlet weak var balance: UILabel!
    
    @IBOutlet weak var totalThisMonth: UILabel!
    
    @IBOutlet weak var expense: UILabel!
    @IBOutlet weak var expensePieChart: PieChartView!
    
    @IBOutlet weak var income: UILabel!
    @IBOutlet weak var incomePieChart: PieChartView!
    
    var transactionData: [TransactionData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Pie chart expense
        let parties = ["Party A", "Party B", "Party C", "Party D", "Party E", "Party F", "Party G"]
        let pieEntries = (0..<parties.count).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(arc4random_uniform(10) + 1), label: parties[i])
        }

        let pieDataSet = PieChartDataSet(entries: pieEntries, label: "Election Results")
        pieDataSet.colors = ChartColorTemplates.material() // Use a color template
        pieDataSet.sliceSpace = 2.0 // Add space between slices
        // Set pastel colors
        let pastelColors = [
            UIColor(red: 255/255, green: 182/255, blue: 193/255, alpha: 1),  // Pastel Pink
            UIColor(red: 255/255, green: 218/255, blue: 185/255, alpha: 1),  // Pastel Peach
            UIColor(red: 255/255, green: 255/255, blue: 204/255, alpha: 1),  // Pastel Yellow
            UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 1),  // Pastel Green
            UIColor(red: 204/255, green: 255/255, blue: 255/255, alpha: 1),  // Pastel Aqua
            UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1),  // Pastel Blue
            UIColor(red: 230/255, green: 230/255, blue: 250/255, alpha: 1),  // Pastel Lavender
            UIColor(red: 255/255, green: 182/255, blue: 255/255, alpha: 1)   // Pastel Purple
        ]
        pieDataSet.colors = pastelColors
        pieDataSet.sliceSpace = 2.0 // Add space between slices
        


        let pieData = PieChartData(dataSet: pieDataSet)
        pieData.setValueTextColor(.black)
        pieData.setValueFont(.systemFont(ofSize: 11))

        expensePieChart.data = pieData
        expensePieChart.holeRadiusPercent = 0.3
        expensePieChart.transparentCircleColor = .clear
        expensePieChart.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)

        // Pie chart for income (using the same dataset for now, can customize similarly)
        incomePieChart.data = pieData
        incomePieChart.holeRadiusPercent = 0.3
        incomePieChart.transparentCircleColor = .clear
        incomePieChart.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
          
        
    }
    

  

}
