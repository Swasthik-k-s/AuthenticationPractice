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
    
    func showAlertWithCancel(title: String, message: String, buttonText: String, buttonAction: @escaping() -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let button = UIAlertAction(title: buttonText, style: .default) { (buttonclick) in
            buttonAction()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (cancelclick) in
        }
        
        alert.addAction(cancel)
        alert.addAction(button)
        
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
    
    func configureScreen() {
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 100/255.0, green: 100/255.0, blue: 200/255.0, alpha: 1.0)

        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
    
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        view.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1.0)
    }
}
