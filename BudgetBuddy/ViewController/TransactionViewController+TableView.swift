//
//  testTransactionViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 17/9/2567 BE.
//

import UIKit

class TransactionViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var transactionNavigation: UINavigationItem!
    
    
    var transaction: [Transaction] = [
        Transaction(
            date: "2024-09-24",
            transactions: [
                TransactionDetail(image: "food", category: "Food", amount: 100),
                TransactionDetail(image: "food", category: "Food", amount: 300),
                TransactionDetail(image: "food", category: "Food", amount: 300)
            ]
        ),
        Transaction(
            date: "2024-09-24",
            transactions: [
                TransactionDetail(image: "drinks", category: "Beverage", amount: 30),
                TransactionDetail(image: "drinks", category: "Beverage", amount: 30),
                TransactionDetail(image: "drinks", category: "Beverage", amount: 30),
                TransactionDetail(image: "drinks", category: "Beverage", amount: 30),
                TransactionDetail(image: "drinks", category: "Beverage", amount: 30)
            ]
        ),
        Transaction(
            date: "2024-09-24",
            transactions: [
                TransactionDetail(image: "shopping", category: "Shopping", amount: 590),
                TransactionDetail(image: "salary", category: "Salary", amount: 10000),
                TransactionDetail(image: "education", category: "Education", amount: 360)
            ]
        ),
        Transaction(
            date: "2024-09-24",
            transactions: [
                TransactionDetail(image: "other", category: "Other Expense", amount: 30),
                TransactionDetail(image: "other", category: "Other Expense", amount: 30),
                TransactionDetail(image: "other", category: "Other Expense", amount: 30)
            ]
        ),
        Transaction(
            date: "2024-09-24",
            transactions: [
                TransactionDetail(image: "other", category: "Other Expense", amount: 30),
                TransactionDetail(image: "other", category: "Other Expense", amount: 30),
                TransactionDetail(image: "other", category: "Other Expense", amount: 30)
            ]
        ),
        
    ]



    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
        self.transactionNavigation.title = self.transactionNavigation.title!.localized()
        self.dateLabel.text = self.dateLabel.text!.localized()
        
    }
    

   

}

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaction.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell") as! TransactionTableViewCell
        cell.dateLabel.text = transaction[i].date
        cell.transaction = transaction[i].transactions
        
        
        return cell
    }
    

    
}
