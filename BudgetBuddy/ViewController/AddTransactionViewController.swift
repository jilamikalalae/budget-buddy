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
    @IBOutlet weak var categoryLabel: UILabel!
   
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var uploadImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.amount.delegate = self
        
        self.addTransactionView.title = "Add Transaction".localized()
        
        self.amountLabel.text =  self.amountLabel.text!.localized()
        self.amount.placeholder = self.amount.placeholder!.localized()
        
        self.categoryLabel.text = self.categoryLabel.text!.localized()
        self.category.setTitle("Select category".localized(), for: .normal)
        
        
        self.noteLabel.text = self.noteLabel.text!.localized()
        self.note.placeholder = self.note.placeholder!.localized()
        
        self.dateLabel.text = self.dateLabel.text!.localized()
        
        self.uploadButton.setTitle("Upload".localized(), for: .normal)
        
        self.addButton.setTitle("Add".localized(), for: .normal)
        
        
        
    }
    
    
    
    @IBAction func openCategoryPicker(_ sender: UIButton) {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController {
               categoryVC.delegate = self // Set delegate before presenting
               self.present(categoryVC, animated: true, completion: nil)
               
           }
       }
    
    
    @IBAction func btnAddTransaction(_ sender: Any) {
        storeBalance(balance: (amount.text!.ToFloat()))
    }
    
    func storeBalance(balance: Float){
        let storeBalance = Balance(balance: balance)
        let primaryData = PrimaryData(balanceData: storeBalance)
        primaryData.encodeData()
    }

        
}

extension AddTransactionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func btnImagePicker(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage{
            self.uploadImage.image = image
        }
        
        dismiss(animated: true)
    }
    
}

extension AddTransactionViewController: CategoryViewDelegate {
    func categorySelected(_ category: Category) {
        self.category.setTitle(category.name.localized(), for: .normal)
        self.category.setTitleColor(UIColor.black, for: .normal)
        
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
