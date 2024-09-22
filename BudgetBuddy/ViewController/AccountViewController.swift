//
//  AccountViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 21/9/2567 BE.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

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
    

    @IBAction func btnSignOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            print("Signed out")
            navigateToLogin()
        } catch let signoutError as NSError {
            print("Error signing out %@", signoutError)
        }
    }
    
    func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        self.view.window?.rootViewController = loginVC
        self.view.window?.makeKeyAndVisible()
    }
    
}
