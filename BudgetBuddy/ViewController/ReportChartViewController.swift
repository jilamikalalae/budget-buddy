//
//  ReportChartViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 19/9/2567 BE.
//

import UIKit
import DGCharts
import FirebaseAuth
import Firebase
import FirebaseDatabase

class ReportChartViewController: UIViewController {
    
    
    @IBOutlet weak var balance: UILabel!
    
    
    @IBOutlet weak var expense: UILabel!
    @IBOutlet weak var expensePieChart: PieChartView!
    @IBOutlet weak var expenseLabel: UILabel!
    
    @IBOutlet weak var income: UILabel!
    @IBOutlet weak var incomePieChart: PieChartView!
    @IBOutlet weak var incomeLabel: UILabel!
    
    
    var transactionData: [TransactionData] = []
    
    var incomeTotal: Float = 0.0 // New variable to hold total income
    var expenseTotal: Float = 0.0 // New variable to hold total expense
    
    // Mock transaction data
    var transactions: [TransactionDetail] = [
        TransactionDetail(id: "1", image: "Food", category: "Food", amount: 50, categoryIcon: "foodIcon", date: "2024-09-01", note: "Lunch", type: .expense),
        TransactionDetail(id: "1", image: "Food", category: "Food", amount: 50, categoryIcon: "foodIcon", date: "2024-09-01", note: "Lunch", type: .expense)
//        TransactionDetail(id: "2", image: "Beverage", category: "Beverage", amount: 20, categoryIcon: "beverageIcon", date: "2024-09-02", note: "Coffee", type: .expense),
//        TransactionDetail(id: "3", image: "Salary", category: "Salary", amount: 2000, categoryIcon: "salaryIcon", date: "2024-09-03", note: "Monthly Salary", type: .income),
//        TransactionDetail(id: "4", image: "Shopping", category: "Shopping", amount: 150, categoryIcon: "shoppingIcon", date: "2024-09-04", note: "New Shoes", type: .expense),
//        TransactionDetail(id: "5", image: "Allowance", category: "Allowance", amount: 100, categoryIcon: "allowanceIcon", date: "2024-09-05", note: "From Parents", type: .income),
//        TransactionDetail(id: "6", image: "Bills", category: "Bills", amount: 100, categoryIcon: "billsIcon", date: "2024-09-06", note: "Electricity Bill", type: .expense),
//        TransactionDetail(id: "7", image: "Pet", category: "Pet", amount: 30, categoryIcon: "petIcon", date: "2024-09-07", note: "Pet Food", type: .expense),
//        TransactionDetail(id: "8", image: "Other income", category: "Other income", amount: 300, categoryIcon: "otherIncomeIcon", date: "2024-09-08", note: "Freelance Work", type: .income)
    ]

    
    let pastelColors = [
        UIColor(red: 0.8, green: 0.6, blue: 1.0, alpha: 1.0), // #cc99ff - Lavender
        UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1.0), // #ccccff - Light Blue
        UIColor(red: 0.6, green: 0.8, blue: 1.0, alpha: 1.0), // #99ccff - Blue
        UIColor(red: 0.8, green: 1.0, blue: 1.0, alpha: 1.0), // #ccffff - Aqua
        UIColor(red: 0.6, green: 1.0, blue: 0.6, alpha: 1.0), // #ccffcc - Light Mint
        UIColor(red: 0.8, green: 1.0, blue: 0.6, alpha: 1.0), // #ccff99 - Light Green
        UIColor(red: 1.0, green: 1.0, blue: 0.7, alpha: 1.0), // #ffffcc - Light Yellow
        UIColor(red: 1.0, green: 0.8, blue: 0.5, alpha: 1.0), // #ffcc99 - Peach
        UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 1.0), // #ffcccc - Light Pink
        UIColor(red: 1.0, green: 0.6, blue: 0.8, alpha: 1.0), // #ff99cc - Pink
        UIColor(red: 1.0, green: 0.8, blue: 1.0, alpha: 1.0), // #ffccff - Pale Pink
        UIColor(red: 0.6, green: 1.0, blue: 0.8, alpha: 1.0)  // #99ffcc - Mint
    ]
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.incomeLabel.text = self.incomeLabel.text!.localized()
        incomeLabel.font = UIFont(name: CustomFont().font, size: incomeLabel.font.pointSize)
        
        self.expenseLabel.text = self.expenseLabel.text!.localized()
        expenseLabel.font = UIFont(name: CustomFont().font, size: expenseLabel.font.pointSize)
        
        fetchTransactions()
          
        
    }
    
    func convertToTransactionDetailArray(transactionDataArray: [TransactionData]) -> [TransactionDetail] {
        return transactionDataArray.compactMap { transactionData in
            // Convert each TransactionData object into TransactionDetail
            return TransactionDetail(
                id: transactionData.id,
                image: transactionData.imgUrl,  // Assuming 'image' maps to 'imgUrl'
                category: transactionData.category.localized(),
                amount: Int(transactionData.amount),  // Converting Float to Int
                categoryIcon: transactionData.categoryIcon,
                date: transactionData.date,
                note: transactionData.note,
                type: transactionData.type  // Assuming 'type' matches between both structs
            )
        }
    }
    
    
    func fetchTransactions() {
        let userId = Auth.auth().currentUser!.uid
        let ref = Database.database().reference().child("users").child(userId) // Adjust the path as needed
        ref.observe(.value) { snapshot  in
            self.transactionData.removeAll()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String: Any],
                   let transaction = TransactionData(dict: dict) {
                    
                    self.transactionData.append(transaction)
                    

                }
            }
            
            
            
            self.transactions = self.convertToTransactionDetailArray(transactionDataArray: self.transactionData)
            print(self.transactions)
            
            self.allReport()
            
            self.setupIncomePieChart()
            self.setupExpensePieChart()
            
            
            
        } withCancel: { error in
            print(error.localizedDescription)
        }
        
    }
    
    func allReport() {
        for transaction in transactions {
            if transaction.type == .income {
                incomeTotal += Float(transaction.amount)
            } else if transaction.type == .expense {
                expenseTotal += Float(transaction.amount)
            }
        }
        
        // Update labels with the calculated totals
        income.text = String(format: "%.2f", incomeTotal)
        expense.text = String(format: "%.2f", expenseTotal)
        
        let balanceAmount = incomeTotal - expenseTotal
        balance.text = String(format: "%.2f", balanceAmount)
    }
    
    
    
    
    private func setupIncomePieChart() {
        let incomeEntries = calculateIncomeEntries()
        let incomeDataSet = PieChartDataSet(entries: incomeEntries, label: "Income")
        incomeDataSet.colors = pastelColors // Use pastel colors for the income pie chart
        
        // Set the value text color to black
        incomeDataSet.valueTextColor = UIColor.black
        
        let incomeData = PieChartData(dataSet: incomeDataSet)
        incomePieChart.data = incomeData
        incomePieChart.chartDescription.enabled = false
        incomePieChart.animate(yAxisDuration: 1.0, easingOption: .easeInOutCubic)
    }

    private func setupExpensePieChart() {
        let expenseEntries = calculateExpenseEntries()
        let expenseDataSet = PieChartDataSet(entries: expenseEntries, label: "Expenses")
        expenseDataSet.colors = pastelColors // Use pastel colors for the expense pie chart
        
        // Set the value text color to black
        expenseDataSet.valueTextColor = UIColor.black
        
        let expenseData = PieChartData(dataSet: expenseDataSet)
        expensePieChart.data = expenseData
        expensePieChart.chartDescription.enabled = false
        expensePieChart.animate(yAxisDuration: 1.0, easingOption: .easeInOutCubic)
    }


   private func calculateIncomeEntries() -> [PieChartDataEntry] {
       var incomeDict: [String: Float] = [:]
       for transaction in transactions {
           if transaction.type == .income {
               incomeDict[transaction.category, default: 0.0] += Float(transaction.amount)
           }
       }
       return incomeDict.map { PieChartDataEntry(value: Double($0.value), label: $0.key) }
   }

   private func calculateExpenseEntries() -> [PieChartDataEntry] {
       var expenseDict: [String: Float] = [:]
       for transaction in transactions {
           if transaction.type == .expense {
               expenseDict[transaction.category, default: 0.0] += Float(transaction.amount)
           }
       }
       return expenseDict.map { PieChartDataEntry(value: Double($0.value), label: $0.key) }
   }
  

}
