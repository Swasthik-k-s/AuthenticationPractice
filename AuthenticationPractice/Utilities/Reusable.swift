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
    
    func passwordValidation(password: String) -> Bool {
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$")
        return passwordRegex.evaluate(with: password)
    }
    
    func emailValidation(email: String) -> Bool {
        let emailRegex = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}")
        return emailRegex.evaluate(with: email)
    }
    
//    func presentViewController(screenIdentifier: String) {
//        let viewController = storyboard!.instantiateViewController(withIdentifier: screenIdentifier)
//        
//        viewController.modalPresentationStyle = .fullScreen
//        
//        present(viewController, animated: true, completion: nil)
//        
//    }
//    
//    func dismissViewController(count: Int) {
//        dismiss(animated: true, completion: nil)
//        
//    }
    
    func navigateHomeScreen() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardConstants.dashboardVCIdentifier)
            
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
        }
        
        func navigateLoginScreen() {
            let loginViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardConstants.loginVCIdentifier)
            
            view.window?.rootViewController = loginViewController
            view.window?.makeKeyAndVisible()
        }
}
