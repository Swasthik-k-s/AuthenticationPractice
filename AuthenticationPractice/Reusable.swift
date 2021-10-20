//
//  Reusable.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 19/10/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (okclick) in
            
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateHomeScreen() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomeVC")
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func navigateLoginScreen() {
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
}
