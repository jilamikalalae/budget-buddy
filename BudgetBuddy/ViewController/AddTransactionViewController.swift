//
//  AddTransactionViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 18/9/2567 BE.
//

import UIKit

class AddTransactionViewController: UIViewController,CategoryViewCellProtocol {
   
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var category: UIButton!
    @IBOutlet weak var date: UIDatePicker!
    
//    let categoryViewController = CategoryViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        categoryViewController.delegate = self
        
    }
    
    
    @IBAction func openCategoryPicker(_ sender: UIButton) {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController {
               categoryVC.delegate = self // Set delegate before presenting
               self.present(categoryVC, animated: true, completion: nil)
           }
       }
    
    
    func categorySelected(_ category: Category) {
        self.category.setTitle(category.name, for: .normal)
        self.category.setTitleColor(UIColor.black, for: .normal)
        
        print("Result from server is \(category)")
    }
    
        
}

 
