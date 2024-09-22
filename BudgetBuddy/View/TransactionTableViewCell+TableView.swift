//
//  dateTableViewCell.swift
//  BudgetBuddy
//
//  Created by Jilamika on 17/9/2567 BE.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var transaction: [TransactionDetail] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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
        cell.photo.image = UIImage(named: transaction[i].image)
        cell.amount.text = String(transaction[i].amount)
        
        
        return cell
    }
    

    
}

