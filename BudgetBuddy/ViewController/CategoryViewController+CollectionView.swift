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
        Category(image: "food", name: "Food", type: .expense),
        Category(image: "drinks", name: "Beverage" , type: .expense),
        Category(image: "car", name: "Car", type: .expense),
        Category(image: "transportion", name: "Public transportation" , type: .expense),
        Category(image: "shopping", name: "Shopping", type: .expense),
        Category(image: "bill", name: "Bills" , type: .expense),
        Category(image: "family", name: "Family", type: .expense),
        Category(image: "extertainment", name: "Entertainment" , type: .expense),
        Category(image: "health", name: "Health & Fitness" , type: .expense),
        Category(image: "pet", name: "Pet" , type: .expense),
        Category(image: "education", name: "Education" , type: .expense),
        Category(image: "other", name: "Other Expense", type: CategoryType.expense)
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
            cell.photo.image = UIImage(named: expenseCategory[itemIndex].name)
           
           
            
            return cell
        } else {
            
            let itemIndex = indexPath.item
            let cell = incomeCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell" ,
                                                          for: indexPath) as! CategoryCollectionViewCell
            
        
            cell.category.text = incomeCategory[itemIndex].name.localized()
            cell.photo.image = UIImage(named: incomeCategory[itemIndex].name)
           
           
            
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

