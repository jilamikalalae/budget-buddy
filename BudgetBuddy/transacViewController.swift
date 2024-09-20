//
//  transacViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 17/9/2567 BE.
//

import UIKit

class transacViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var transaction: [TransactionDate] = [
        TransactionDate(
            date: "September 12, 2024",
            transactions: [
                Transaction(image: "car", category: "parking fee", amount: 30),
                Transaction(image: "car", category: "parking fee", amount: 30),
                Transaction(image: "car", category: "parking fee", amount: 30)
            ]
        ),
        TransactionDate(
            date: "September 13, 2024",
            transactions: [
                Transaction(image: "food", category: "parking fee", amount: 30),
                Transaction(image: "food", category: "parking fee", amount: 30),
                Transaction(image: "food", category: "parking fee", amount: 30)
            ]
        )
]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
    


}
extension transacViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaction.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell") as! dateTableViewCell
        cell.month.text = transaction[i].date
        
        return cell
    }
    

    
}
