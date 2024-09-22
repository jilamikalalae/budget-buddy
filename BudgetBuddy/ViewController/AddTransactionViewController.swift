//
//  AddTransactionViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 18/9/2567 BE.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

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
    
    var categoryType: CategoryType = .income
    
    
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
        
        let amountNSNumber = NSNumber(value: amount.text!.ToFloat())
        
        let transaction: [String: Any] = [
            "amount": amountNSNumber as NSObject,
            "category": category.titleLabel!.text!,
            "type": categoryType.stringValue,
            "note": note.text!,
            "date": date.date.ToString(),
            "imgUrl": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-photos%2Fpic&psig=AOvVaw3IxhsedtYFoOfboKSqMeoA&ust=1727106064934000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCNiku83x1ogDFQAAAAAdAAAAABAE"
            
        ]
        let transactionId = UUID().uuidString
        let userId = Auth.auth().currentUser!.uid
        database.child("users").child(userId).child(transactionId).setValue(transaction)
        
        navigateToTransaction()
    }
    
    func storeBalance(balance: Float){
        let storeBalance = Balance(balance: balance)
        let primaryData = PrimaryData(balanceData: storeBalance)
        primaryData.encodeData()
    }
    
    func navigateToTransaction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarC") as! TabBarController
        tabBarController.selectedIndex = 0
        self.view.window?.rootViewController = tabBarController
        self.view.window?.makeKeyAndVisible()
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
        self.categoryType = category.type
        
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


