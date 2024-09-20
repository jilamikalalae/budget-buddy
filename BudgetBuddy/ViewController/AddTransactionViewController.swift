//
//  AddTransactionViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 18/9/2567 BE.
//

import UIKit

class AddTransactionViewController: UIViewController  {
   
    
    @IBOutlet weak var addTransactionView: UINavigationItem!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var category: UIButton!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var note: UITextField!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.amountLabel.text =  self.amountLabel.text!.localized()
        self.amount.placeholder = self.amount.placeholder!.localized()
        self.addTransactionView.title = "Add Transaction".localized()
        self.amount.delegate = self
        
    }
    
    
    @IBAction func openCategoryPicker(_ sender: UIButton) {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController {
               categoryVC.delegate = self // Set delegate before presenting
               self.present(categoryVC, animated: true, completion: nil)
               
           }
       }

        
}

extension AddTransactionViewController: CategoryViewDelegate {
    func categorySelected(_ category: Category) {
        self.category.setTitle(category.name, for: .normal)
        self.category.setTitleColor(UIColor.black, for: .normal)
        
        print("Result from server is \(category)")
    }
}

extension AddTransactionViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return amount.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
