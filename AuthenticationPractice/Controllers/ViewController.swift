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
        
    }
}

