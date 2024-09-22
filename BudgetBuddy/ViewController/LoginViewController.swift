//
//  LoginViewController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 22/9/2567 BE.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("Missing clientID in GoogleService-Info.plist")
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        
        
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserSignInStatus()
    }
    
    
    @IBAction func btnSignin(_ sender: Any) {
        print("Sign-in button tapped")
        
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            
            guard let user = signInResult?.user, let idToken = user.idToken?.tokenString else {
                print("No user or idToken")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error authenticating: \(error.localizedDescription)")
                    return
                }
                print("User signed in: \(authResult?.user.uid ?? "")")
                self.showHomeScreen()
            }
        }
    }
    
    func checkUserSignInStatus() {
        if Auth.auth().currentUser != nil {
            print("User sign in: \(Auth.auth().currentUser!.uid)")
            self.showHomeScreen()
        }else{
            print("This is login view controller and  user is not login yet bruh")
        }
    }
    
    func showHomeScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarC") as! TabBarController
        self.view.window?.rootViewController = tabBarController
        self.view.window?.makeKeyAndVisible()
    }
    

    
}
