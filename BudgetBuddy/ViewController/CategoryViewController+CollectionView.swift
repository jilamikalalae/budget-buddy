//
//  CategoryViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 18/9/2567 BE.
//

import UIKit

protocol CategoryViewCellProtocol{
    func categorySelected(_ category: Category)
}

class CategoryViewController: UIViewController {
    
    var delegate: CategoryViewCellProtocol?
    
    @IBOutlet weak var categoryType: UILabel!
    
    var expenseCategory: [Category] = [
        Category(image: "car", name: "parking fee", type: .expense),
        Category(image: "drinks", name: "drink" , type: .expense),
        Category(image: "car", name: "parking fee", type: .expense),
        Category(image: "drinks", name: "drink" , type: .expense),
        Category(image: "car", name: "parking fee", type: .expense),
        Category(image: "drinks", name: "drink" , type: .expense),
        Category(image: "car", name: "parking fee", type: .expense),
        Category(image: "drinks", name: "drink" , type: .expense),
        Category(image: "food", name: "food", type: CategoryType.expense)
    ]
    
    var incomeCategory: [Category] = [
        Category(image: "salary", name: "Salary", type: .income),
        Category(image: "other", name: "Other income" , type: .income),
        Category(image: "incoming", name: "Incoming transfer", type: .income),
        Category(image: "threedots", name: "Uncategorized Income" , type: .income),
        Category(image: "allowance", name: "Allowance", type: .income)
    ]

    
    @IBOutlet weak var expenseCollectionView: UICollectionView!
    @IBOutlet weak var incomeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        expenseCollectionView.delegate = self
        incomeCollectionView.delegate = self
        
        expenseCollectionView.dataSource = self
        incomeCollectionView.dataSource = self
        
    }
    

   
}
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.expenseCollectionView{
            return expenseCategory.count
        } else {
            return incomeCategory.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        if collectionView == self.expenseCollectionView{
            let itemIndex = indexPath.item
            let cell = expenseCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell" ,
                                                          for: indexPath) as! CategoryCollectionViewCell
            
        
            cell.category.text = expenseCategory[itemIndex].name
            cell.photo.image = UIImage(named: expenseCategory[itemIndex].image)
           
           
            
            return cell
        } else {
            
            let itemIndex = indexPath.item
            let cell = incomeCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell" ,
                                                          for: indexPath) as! CategoryCollectionViewCell
            
        
            cell.category.text = incomeCategory[itemIndex].name
            cell.photo.image = UIImage(named: incomeCategory[itemIndex].image)
           
           
            
            return cell
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Click \(indexPath.row)")
    
        
        if collectionView == self.expenseCollectionView{
            let selectedProduct = expenseCategory[indexPath.item]
//            print(selectedProduct)
            self.delegate?.categorySelected(selectedProduct)
        } else {
            
            let selectedProduct = incomeCategory[indexPath.item]
//            print(selectedProduct)
            
            self.delegate?.categorySelected(selectedProduct)
        }

        
        
        self.dismiss(animated: true)
    }
    
    
}

