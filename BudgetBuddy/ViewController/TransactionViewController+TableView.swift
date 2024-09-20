//
//  testTransactionViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 17/9/2567 BE.
//

import UIKit

class TransactionViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    
    var transaction: [Transaction] = [
        Transaction(
            date: "September 12, 2024",
            transactions: [
                TransactionDetail(image: "car", category: "parking fee", amount: 30),
                TransactionDetail(image: "car", category: "parking fee", amount: 30),
                TransactionDetail(image: "car", category: "parking fee", amount: 30)
            ]
        ),
        Transaction(
            date: "September 13, 2024",
            transactions: [
                TransactionDetail(image: "food", category: "parking fee", amount: 30),
                TransactionDetail(image: "food", category: "parking fee", amount: 30),
                TransactionDetail(image: "food", category: "parking fee", amount: 30)
            ]
        ),
        Transaction(
            date: "September 13, 2024",
            transactions: [
                TransactionDetail(image: "food", category: "parking fee", amount: 30),
                TransactionDetail(image: "food", category: "parking fee", amount: 30),
                TransactionDetail(image: "food", category: "parking fee", amount: 30)
            ]
        ),
        Transaction(
            date: "September 13, 2024",
            transactions: [
                TransactionDetail(image: "food", category: "parking fee", amount: 30),
                TransactionDetail(image: "food", category: "parking fee", amount: 30),
                TransactionDetail(image: "food", category: "parking fee", amount: 30)
            ]
        ),
        Transaction(
            date: "September 13, 2024",
            transactions: [
                TransactionDetail(image: "food", category: "parking fee", amount: 30),
                TransactionDetail(image: "food", category: "parking fee", amount: 30),
                TransactionDetail(image: "food", category: "parking fee", amount: 30)
            ]
        ),
        
        Transaction(
            date: "September 14, 2024",
            transactions: [
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30),
                TransactionDetail(image: "drinks", category: "parking fee", amount: 30)
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
        cell.month.text = transaction[i].date
        cell.transaction = transaction[i].transactions
        
        
        return cell
    }
    

    
}
