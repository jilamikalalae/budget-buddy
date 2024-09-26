//
//  transacTableViewCell.swift
//  BudgetBuddy
//
//  Created by Jilamika on 17/9/2567 BE.
//

import UIKit

class TransactionDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var photo: UIImageView!
    

    var categoryType: CategoryType?


    override func awakeFromNib() {
        super.awakeFromNib()
        
        amount.font = UIFont(name: CustomFont().font, size: amount.font.pointSize)
        category.font = UIFont(name: CustomFont().font, size: category.font.pointSize)

    }
    
    func configureCell(with categoryType: CategoryType) {
            self.categoryType = categoryType

            switch categoryType {
            case .income:
                amount.textColor = UIColor.systemGreen  // Green for income
            case .expense:
                amount.textColor = UIColor.red    // Red for expense
            }
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }

}

