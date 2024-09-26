//
//  CategoryViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 18/9/2567 BE.
//

import UIKit

protocol CategoryViewDelegate{
    func categorySelected(_ category: Category)
}

class CategoryViewController: UIViewController {
    
    var delegate: CategoryViewDelegate?
    
    @IBOutlet weak var categoryType: UILabel!
    
    var expenseCategory: [Category] = [
        Category(image: "Food", name: "Food", type: .expense),
        Category(image: "Beverage", name: "Beverage" , type: .expense),
        Category(image: "Car", name: "Car", type: .expense),
        Category(image: "Public transportation", name: "Public transportation" , type: .expense),
        Category(image: "Shopping", name: "Shopping", type: .expense),
        Category(image: "Bills", name: "Bills" , type: .expense),
        Category(image: "Family", name: "Family", type: .expense),
        Category(image: "Entertainment", name: "Entertainment" , type: .expense),
        Category(image: "Health & Fitness", name: "Health & Fitness" , type: .expense),
        Category(image: "Pet", name: "Pet" , type: .expense),
        Category(image: "Education", name: "Education" , type: .expense),
        Category(image: "Other Expense", name: "Other Expense", type: CategoryType.expense)
    ]
    
    var incomeCategory: [Category] = [
        Category(image: "Salary", name: "Salary", type: .income),
        Category(image: "Other income", name: "Other income" , type: .income),
        Category(image: "Incoming transfer", name: "Incoming transfer", type: .income),
        Category(image: "Uncategorized Income", name: "Uncategorized Income" , type: .income),
        Category(image: "Allowance", name: "Allowance", type: .income)
    ]

    
    @IBOutlet weak var expenseCollectionView: UICollectionView!
    @IBOutlet weak var incomeCollectionView: UICollectionView!
    
    
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        expenseCollectionView.delegate = self
        incomeCollectionView.delegate = self
        
        expenseCollectionView.dataSource = self
        incomeCollectionView.dataSource = self
        
        self.expenseLabel.text = self.expenseLabel.text!.localized()
        self.incomeLabel.text = self.incomeLabel.text!.localized()
        
        categoryType.font =  UIFont(name: CustomFont().font, size: categoryType.font.pointSize)
        
        expenseLabel.font =  UIFont(name: CustomFont().font, size: expenseLabel.font.pointSize)
        
        incomeLabel.font =  UIFont(name: CustomFont().font, size: incomeLabel.font.pointSize)
        
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
            
        
            cell.category.text = expenseCategory[itemIndex].name.localized()
            cell.photo.image = UIImage(named: expenseCategory[itemIndex].image)
            
           
           
            
            return cell
        } else {
            
            let itemIndex = indexPath.item
            let cell = incomeCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell" ,
                                                          for: indexPath) as! CategoryCollectionViewCell
            
        
            cell.category.text = incomeCategory[itemIndex].name.localized()
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

