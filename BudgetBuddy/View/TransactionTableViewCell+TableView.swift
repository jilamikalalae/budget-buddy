//
//  dateTableViewCell.swift
//  BudgetBuddy
//
//  Created by Jilamika on 17/9/2567 BE.
//

import UIKit

protocol TransactionTableViewCellDelegate: AnyObject {
    func didSelectTransaction(_ transaction: TransactionDetail)
}

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var transaction: [TransactionDetail] = []
    
    
    var delegate: TransactionTableViewCellDelegate?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        dateLabel.font = UIFont(name: CustomFont().font, size: dateLabel.font.pointSize)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TransactionTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaction.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TransactionDetailTableViewCell
        cell.category.text = transaction[i].category.localized()
        cell.photo.image = UIImage(named: transaction[i].categoryIcon)
        cell.amount.text = String(transaction[i].amount)
        cell.categoryType = transaction[i].type
        cell.configureCell(with: transaction[i].type) 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = transaction[indexPath.row]
        delegate?.didSelectTransaction(transaction)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let transaction = transaction[indexPath.row]
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            if let editTransactionVC = storyboard.instantiateViewController(withIdentifier: "EditTransactionVC") as? EditTransactionViewController {
//                editTransactionVC.transaction = transaction
//                
//                self.navigationController?.pushViewController(editTransactionVC, animated: true)
//            } else {
//                print("Error: Unable to instantiate view controller with identifier 'EditTransactionVC'")
//            }
//        }
//    

    
}




