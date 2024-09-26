//
//  testTransactionViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 17/9/2567 BE.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class TransactionViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var transactionNavigation: UINavigationItem!
    
    @IBOutlet weak var balance: UILabel!
    
    
    
    var transactionData: [TransactionData] = []
    
    
    var transaction: [Transaction] = []



    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
        self.transactionNavigation.title = self.transactionNavigation.title!.localized()
        
        fetchTransactions()
        
        
        
        
        balance.font = UIFont(name: CustomFont().font, size: balance.font.pointSize)
       
        
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
            self.transaction = self.mapTransactions(transactionDataArray: self.transactionData)
            print(self.transaction)
            self.tableView.reloadData()
            
        } withCancel: { error in
            print(error.localizedDescription)
        }
        
    }
    
    func mapTransactions(transactionDataArray: [TransactionData]) -> [Transaction] {
        // Grouping the transactions by date
        var groupedTransactions = [String: [TransactionDetail]]()

        for transactionData in transactionDataArray {
            let detail = TransactionDetail(image: transactionData.imgUrl,
                                           category: transactionData.category,
                                           amount: Int(transactionData.amount),
                                           categoryIcon: transactionData.categoryIcon)
            if groupedTransactions[transactionData.date] != nil {
                groupedTransactions[transactionData.date]?.append(detail)
            } else {
                groupedTransactions[transactionData.date] = [detail]
            }
        }
        print(groupedTransactions)

        // Mapping grouped transactions to Transaction
        return groupedTransactions.map { (date, transactions) in
            Transaction(date: date, transactions: transactions)
        }.sorted { $0.date > $1.date }  
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
        cell.tableView.reloadData()
        
       
        
        
        return cell
    }
    

    
}
