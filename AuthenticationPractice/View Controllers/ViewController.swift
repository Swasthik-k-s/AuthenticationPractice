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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        GIDSignIn.sharedInstance().presentingViewController = self
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if NetworkManager.shared.getUID() != nil {
            navigateHomeScreen()
            print("Logged In")
        } else {
            print("Logged Out")
        }
    }
    
    @IBAction func googleSignInPressed(_ sender: Any) {
        
    }
    
    @IBAction func facebookSignInPressed(_ sender: Any) {
        
    }
}

