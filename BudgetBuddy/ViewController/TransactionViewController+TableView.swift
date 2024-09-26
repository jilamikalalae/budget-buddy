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

class TransactionViewController: UIViewController, TransactionTableViewCellDelegate {
    
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
    
    func didSelectTransaction(_ transaction: TransactionDetail) {
        print("HELLO")
        if let editTransactionVC = storyboard?.instantiateViewController(withIdentifier: "EditTransactionVC") as? EditTransactionViewController {
            editTransactionVC.transaction = transaction
            self.navigationController?.pushViewController(editTransactionVC, animated: true)
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
            self.transaction = self.mapTransactions(transactionDataArray: self.transactionData)
            print(self.transaction)
            
            var totalBalance = self.calculateBalance()
            
            self.balance.text = String(totalBalance)
            self.storeBalance(balance: totalBalance)
            
            
            self.tableView.reloadData()
            
        } withCancel: { error in
            print(error.localizedDescription)
        }
        
    }
    
    func calculateBalance() -> Float {
        var balance:Float = 0.0
        for v in transactionData {
            if v.type == .income {
                balance = balance + v.amount
            } else {
                balance = balance - v.amount
            }
        }
        return balance
    }
    
    func storeBalance(balance: Float){
        let storeBalance = Balance(balance: balance)
        let primaryData = PrimaryData(balanceData: storeBalance)
        primaryData.encodeData()
    }
    
    func mapTransactions(transactionDataArray: [TransactionData]) -> [Transaction] {
        // Grouping the transactions by date
        var groupedTransactions = [String: [TransactionDetail]]()

        for transactionData in transactionDataArray {
            let detail = TransactionDetail(id: transactionData.id,
                                           image: transactionData.imgUrl,
                                           category: transactionData.category,
                                           amount: Int(transactionData.amount),
                                           categoryIcon: transactionData.categoryIcon,
                                           date: transactionData.date,
                                           note: transactionData.note,
                                           type: transactionData.type
            )
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
        cell.delegate = self  
        cell.tableView.reloadData()
        
        
        
        
        return cell
    }
    
    
}

