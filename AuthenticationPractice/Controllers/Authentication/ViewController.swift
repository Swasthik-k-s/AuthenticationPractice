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
            if let error = error {
                self.showAlert(title: "Failed", message: error.localizedDescription)
                return
            }
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { user, error in
                if let error = error {
                    self.showAlert(title: "Login Error", message: error.localizedDescription)
                    return
                } else {
                    NetworkManager.shared.getUser { result in
                        switch result {
                            
                        case .success(let data):
                            let user = data["uid"] as? String ?? ""
                            if user == "" {
                                let uid = NetworkManager.shared.getUID()
                                let content: [String: Any] = ["username": "Google User",
                                                              "uid": uid!]
                                NetworkManager.shared.addUser(collectionName: "users",data: content)
                            }
                            self.navigateHomeScreen()
                        case .failure(let error):
                            self.showAlert(title: "Failed to Login with Google", message: error.localizedDescription)
                            
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func facebookSignInPressed(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { result, error in
            if let error = error {
                self.showAlert(title: "Failed", message: error.localizedDescription)
                return
            }
            guard let accessToken = AccessToken.current else {
                print("Failed to get Access Token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { user, error in
                if let error = error {
                    self.showAlert(title: "Login Error", message: error.localizedDescription)
                    return
                } else {
                    NetworkManager.shared.getUser { result in
                        switch result {
                            
                        case .success(let data):
                            let user = data["uid"] as? String ?? ""
                            if user == "" {
                                let uid = NetworkManager.shared.getUID()
                                let content: [String: Any] = ["username": "Facebook User",
                                                              "uid": uid!]
                                NetworkManager.shared.addUser(collectionName: "users",data: content)
                            }
                            self.navigateHomeScreen()
                        case .failure(let error):
                            self.showAlert(title: "Failed to Login with Facebook", message: error.localizedDescription)
                            
                        }
                    }
                }
            }
        }
    }
}

