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
import LocalAuthentication

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
        
        let userEmail = Auth.auth().currentUser!.email!
        self.userEmail.text = userEmail
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("Missing clientID in GoogleService-Info.plist")
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        
        
        
        // Custom fonts
//        userEmail.font = UIFont(name: CustomFont().font, size: userEmail.font.pointSize)

        
        signoutButton.titleLabel?.font = UIFont(name: CustomFont().font, size: signoutButton.titleLabel?.font.pointSize ?? 24)
        
        deleteAccountButton.titleLabel?.font = UIFont(name: CustomFont().font, size: deleteAccountButton.titleLabel?.font.pointSize ?? 24)
        
        
        
    

        
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
    
    
    @IBAction func btnDeleteAccount(_ sender: Any) {
        reSigninAndDelete()
    }
    
    func biometricAuthentication() {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Try manual Login/Touch"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {[weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        self?.showError(title: "Authentication Failed", message: "Please try again.")
                        return
                    }
                    Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).removeValue()
                    Auth.auth().currentUser!.delete { error in
                        if let error = error {
                            print(error)
                            self?.showError(title: "Delete Failed", message: "Please try again")
                        }
                        self!.showLoginScreen()
                        
                        return
                    }                   
                }
            }
            
        }
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style:  .default))
        self.present(alert, animated: true)
    }
    
    func reSigninAndDelete() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            
            guard let authentication = signInResult?.user, let idToken = authentication.idToken?.tokenString else {
                print("No user or idToken")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken.tokenString)
            
            Auth.auth().currentUser!.reauthenticate(with: credential) { result,error  in
              if let error = error {
                  print(error)
                  self.showError(title: "Reauthenticate Failed", message: "Please try again later")
                  return
              }
            }
            
            self.biometricAuthentication()
            
        }
        
        
    }
    
    
    func showLoginScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        self.view.window?.rootViewController = loginViewController
        self.view.window?.makeKeyAndVisible()
    }
    
}
