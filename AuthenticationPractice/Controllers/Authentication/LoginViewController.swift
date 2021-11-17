//
//  LoginViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 19/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        passwordIcon.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(iconTapped(recognizer: )))
        
        passwordIcon.addGestureRecognizer(tapRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func iconTapped(recognizer: UITapGestureRecognizer) {
        let tappedImage =  recognizer.view as! UIImageView

        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        if passwordTextField.isSecureTextEntry {
            tappedImage.image = UIImage(systemName: "eye.slash")
        } else {
            tappedImage.image = UIImage(systemName: "eye")
        }
    }
    
    func validateUser(email: String?, password: String?) -> String? {
        
        //Check if fields are empty
        if email == "" ||
            password == "" {
            
            return messageConstants.emptyFields
        }
        
        //Check is email is valid
        if !emailValidation(email: email!) {
            return messageConstants.emailInvalid
        }
        
        //Check if password is valid
//        if !passwordValidation(password: password!) {
//
//            return messageConstants.passwordInvalid
//        }
        
        return nil
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        let error = validateUser(email: emailTextField.text, password: passwordTextField.text)
        
        if error != nil {
            showAlert(title: "Invalid", message: error!)
        } else {
            NetworkManager.shared.login(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] result, error in
                
                if error != nil {
                    self!.showAlert(title: "Failed", message: error!.localizedDescription)
                } else {
                    self!.navigateHomeScreen()
                }
            }
        }
    }
   
    
}
