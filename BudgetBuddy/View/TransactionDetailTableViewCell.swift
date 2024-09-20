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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

