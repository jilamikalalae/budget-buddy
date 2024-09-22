//
//  AccountViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 21/9/2567 BE.
//

import UIKit

class AccountViewController: UIViewController {
    
    
    @IBOutlet weak var accountNavigation: UINavigationItem!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var signoutButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.accountNavigation.title = self.accountNavigation.title!.localized()
        self.signoutButton.setTitle("Sign out".localized(), for: .normal)
        self.deleteAccountButton.setTitle("Delete account".localized(), for: .normal)
        
    }
    


}
