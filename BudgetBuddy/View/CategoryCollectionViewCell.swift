//
//  CategoryCollectionViewCell.swift
//  BudgetBuddy
//
//  Created by Jilamika on 18/9/2567 BE.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var category: UILabel!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Set custom font for the category label
            category.font = UIFont(name: CustomFont().font, size: category.font.pointSize)
        }
}
