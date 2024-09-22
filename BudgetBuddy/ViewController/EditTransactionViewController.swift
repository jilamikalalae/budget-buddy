//
//  editTransactionViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 21/9/2567 BE.
//

import UIKit

class EditTransactionViewController: UIViewController {
    
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountTextFeild: UITextField!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.amountLabel.text = self.amountLabel.text!.localized()
        self.amountTextFeild.placeholder = self.amountTextFeild.placeholder!.localized()
        
        self.categoryLabel.text = self.categoryLabel.text!.localized()
        self.categoryButton.setTitle("Select category".localized(), for: .normal)
        
        self.noteLabel.text = self.noteLabel.text!.localized()
        self.noteTextField.placeholder = self.noteTextField.placeholder!.localized()
        
        self.dateLabel.text = self.dateLabel.text!.localized()
        
        self.uploadButton.setTitle("Upload".localized(), for: .normal)
        
        self.saveButton.setTitle("Save".localized(), for: .normal)
        self.deleteButton.setTitle("Delete".localized(), for: .normal)
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
