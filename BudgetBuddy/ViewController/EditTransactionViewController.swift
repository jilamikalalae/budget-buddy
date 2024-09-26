//
//  editTransactionViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 21/9/2567 BE.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase


class EditTransactionViewController: UIViewController {
    
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountTextFeild: UITextField!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var showDate: UILabel!
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var uploadImage: UIImageView!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var transaction: TransactionDetail = TransactionDetail(id: "",image: "", category: "Enter Category", amount: 0, categoryIcon: "", date: "", note: "", type: .income)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.amountLabel.text = self.amountLabel.text!.localized()
        self.amountTextFeild.placeholder = self.amountTextFeild.placeholder!.localized()
        amountTextFeild.text = String(transaction.amount)
        
        self.categoryLabel.text = self.categoryLabel.text!.localized()
        self.categoryButton.setTitle("Select category".localized(), for: .normal)
        categoryButton.setTitle(transaction.category, for: .normal)
        categoryButton.setTitleColor(.black, for: .normal)
        
        self.noteLabel.text = self.noteLabel.text!.localized()
        self.noteTextField.placeholder = self.noteTextField.placeholder!.localized()
        noteTextField.text = transaction.note
        
        self.dateLabel.text = self.dateLabel.text!.localized()
        showDate.text = transaction.date
        
        self.uploadButton.setTitle("Upload".localized(), for: .normal)
        
        
        self.deleteButton.setTitle("Delete".localized(), for: .normal)
        
        
        amountTextFeild.isUserInteractionEnabled = false
        categoryButton.isEnabled = false
        noteTextField.isUserInteractionEnabled = false
        
        // Custom fonts
        amountLabel.font = UIFont(name: CustomFont().font, size: amountLabel.font.pointSize)
        amountTextFeild.font = UIFont(name: CustomFont().font, size: amountTextFeild.font?.pointSize ?? 24)
        
        categoryLabel.font = UIFont(name: CustomFont().font, size: categoryLabel.font.pointSize)
        categoryButton.titleLabel?.font = UIFont(name: CustomFont().font, size: categoryButton.titleLabel?.font.pointSize ?? 24)
        
        noteLabel.font = UIFont(name: CustomFont().font, size: noteLabel.font?.pointSize ?? 17)
        noteTextField.font = UIFont(name: CustomFont().font, size: noteTextField.font?.pointSize ?? 24)
        
        dateLabel.font = UIFont(name: CustomFont().font, size: dateLabel.font?.pointSize ?? 17)
        
        uploadButton.titleLabel?.font = UIFont(name: CustomFont().font, size: uploadButton.titleLabel?.font.pointSize ?? 17)
        
       
        deleteButton.titleLabel?.font = UIFont(name: CustomFont().font, size: deleteButton.titleLabel?.font.pointSize ?? 17)
        
        
        
        
    }
    
    
    @IBAction func btnDelete(_ sender: Any) {
        let userId = Auth.auth().currentUser!.uid
        Database.database().reference().child("users").child(userId).child(transaction.id).removeValue()
        
        showHomeScreen()
    }
    
    func showHomeScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarC") as! TabBarController
        self.view.window?.rootViewController = tabBarController
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func openCategoryPicker(_ sender: UIButton) {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController {
               categoryVC.delegate = self // Set delegate before presenting
               self.present(categoryVC, animated: true, completion: nil)
               
           }
       }
    

}

extension EditTransactionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension EditTransactionViewController: CategoryViewDelegate {
    func categorySelected(_ category: Category) {
        self.categoryButton.setTitle(category.name.localized(), for: .normal)
        self.categoryButton.setTitleColor(UIColor.black, for: .normal)
        

    }
}
