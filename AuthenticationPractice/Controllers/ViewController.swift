//
//  ViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 19/10/21.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController {
    
    let signInConfig = GIDConfiguration.init(clientID: APIConstants.clientID)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        GIDSignIn.sharedInstance().presentingViewController = self
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func googleSignInPressed(_ sender: Any) {
        
        let signInConfig = GIDConfiguration.init(clientID: APIConstants.clientID)
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            if error == nil {
                print("Done")
                self.navigateHomeScreen()
            } else {
                print("Failed")
            }
        }
        
    }
    
    @IBAction func facebookSignInPressed(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { result, error in
            if let error = error {
                print("Failed to Login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("Failed to get Access Token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { user, error in
                if let error = error {
                    print("Login Error: \(error.localizedDescription)")
                    self.showAlert(title: "Login Error", message: error.localizedDescription)
                    return
                } else {
                    let content: [String: Any] = ["username": "",
                                                  "uid": Auth.auth().currentUser?.uid ?? ""]
                    NetworkManager.shared.writeDB(collectionName: "users",data: content)
                    self.navigateHomeScreen()
                }
            }
        }
    }
}

