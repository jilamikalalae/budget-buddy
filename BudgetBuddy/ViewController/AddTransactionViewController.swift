//
//  AddTransactionViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 18/9/2567 BE.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class AddTransactionViewController: UIViewController  {
   
    private let database = Database.database().reference()
    
    
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
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBOutlet weak var amountError: UILabel!
    @IBOutlet weak var categoryError: UILabel!
    
    var categoryName: String = ""
    var categoryType: CategoryType = .income
    var categoryIcon: String = ""
    
    
    let storage = Storage.storage().reference()
    
    
    
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
        

        datePicker.calendar = Calendar(identifier: .gregorian)
        
        
        
        
        // Custom fonts
        amountLabel.font = UIFont(name: CustomFont().font, size: amountLabel.font.pointSize)
        amount.font = UIFont(name: CustomFont().font, size: amount.font?.pointSize ?? 24)
        
        categoryLabel.font = UIFont(name: CustomFont().font, size: categoryLabel.font.pointSize)
        category.titleLabel?.font = UIFont(name: CustomFont().font, size: category.titleLabel?.font.pointSize ?? 24)
           
        noteLabel.font = UIFont(name: CustomFont().font, size: noteLabel.font?.pointSize ?? 17)
        note.font = UIFont(name: CustomFont().font, size: note.font?.pointSize ?? 24)
        
        dateLabel.font = UIFont(name: CustomFont().font, size: dateLabel.font?.pointSize ?? 17)
        
        uploadButton.titleLabel?.font = UIFont(name: CustomFont().font, size: uploadButton.titleLabel?.font.pointSize ?? 17)
        
        addButton.titleLabel?.font = UIFont(name: CustomFont().font, size: addButton.titleLabel?.font.pointSize ?? 17)
        
       

    }
    
    
    @IBAction func amountChanged(_ sender: Any) {
        var amountText = self.amount.text!
        // Remove leading zero if it exists
        if amountText.first == "0", amountText.count > 1, amountText[amountText.index(after: amountText.startIndex)] != "." {
            amountText.removeFirst()
        }
        
        if amountText.first == "." {
            amountText = "0" + amountText
        }
        
        // Allow only digits and one decimal point
        let allowedCharacters = NSCharacterSet(charactersIn: "0123456789.").inverted
        let components = amountText.components(separatedBy: allowedCharacters)
        amountText = components.joined(separator: "")
        
        // Ensure only one decimal point and restrict to two decimal places
        if let dotIndex = amountText.firstIndex(of: ".") {
            let decimalPart = amountText[amountText.index(after: dotIndex)...]
            
            // Trim the decimal part to only two characters
            if decimalPart.count > 2 {
                amountText = String(amountText.prefix(upTo: amountText.index(dotIndex, offsetBy: 3)))
            }
            
            // Remove any additional decimal points if present
            let parts = amountText.split(separator: ".", omittingEmptySubsequences: false)
            if parts.count > 2 {
                amountText = parts[0] + "." + parts[1]
            }
        }
        
        // Update the text field
        self.amount.text = amountText
    }
    
    @IBAction func openCategoryPicker(_ sender: UIButton) {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController {
               categoryVC.delegate = self // Set delegate before presenting
               self.present(categoryVC, animated: true, completion: nil)
               
           }
       }
    
    
    @IBAction func btnAddTransaction(_ sender: Any) {
        
        if !validateText() {
            return
        }
        
        var isCheck = validateText()
        
        if !isCheck { // isCheck != true
            return
        }
        
        let storageRef = storage.child("images/file.png")
        if let imagePng = uploadImage.image?.pngData() {
            storageRef.putData(imagePng,
                               metadata: nil,
                               completion: {_, error in
                    guard error == nil else {
                        print("Failed to upload")
                        return
                    }
                    storageRef.downloadURL(completion: {url , error in
                            guard error == nil else {
                                print("Failed to upload")
                                return
                            }
                        
                       
                        let urlString  = url!.absoluteString
                        self.createTransaction(url: urlString)
                        }
                    )
                }
            )
        } else {
            createTransaction(url: "")
        }
        
       
        
       
        
    }
    
    func createTransaction(url: String) {
        let amountNSNumber = NSNumber(value: amount.text!.ToFloat())
        let transactionId = UUID().uuidString
        
        let transaction: [String: Any] = [
            "id": transactionId,
            "amount": amountNSNumber as NSObject,
            "category": categoryName,
            "categoryIcon": categoryIcon,
            "type": categoryType.stringValue,
            "note": note.text!,
            "date": date.date.ToString(),
            "imgUrl": url
            
        ]
       
        let userId = Auth.auth().currentUser!.uid
        database.child("users").child(userId).child(transactionId).setValue(transaction)
        navigateToTransaction()
    }
    
    
    
    func navigateToTransaction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarC") as! TabBarController
        tabBarController.selectedIndex = 0
        self.view.window?.rootViewController = tabBarController
        self.view.window?.makeKeyAndVisible()
    }

    func validateText() -> Bool {
        var isCheck = true
        amountError.isHidden = true
        categoryError.isHidden = true
        if amount.text == nil || amount.text!.isEmpty {
            amountError.isHidden = false
            amountError.text = "Amount is required".localized()
            isCheck = false
        }
        
        if category.titleLabel!.text! == "Select category".localized(){
            categoryError.isHidden = false
            categoryError.text = "Category is required".localized()
            isCheck = false
        }
        
        return isCheck
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
        
        self.categoryName = category.name
        self.categoryType = category.type
        self.categoryIcon = category.image
        
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


