//
//  SignUpViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 19/10/21.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
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
    
        tappedImage.image = passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
    }
    
    // Validate the user inputs
    // returns nil if validated else error message
    func validateUser(username: String?, email: String?, password: String?) -> String? {
        // Check if fields are empty
        if username == "" ||
            email == "" ||
            password == "" {
            
            return messageConstants.emptyFields
        }
        
        //Check is email is valid
        if !emailValidation(email: email!) {
            return messageConstants.emailInvalid
        }
        
        //Check if password is valid
        if !passwordValidation(password: password!) {
            
            return messageConstants.passwordInvalid
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        let error = validateUser(username: userNameTextField.text, email: emailTextField.text, password: passwordTextField.text)
        
        if error != nil {
            showAlert(title: "Invalid", message: error!)
            
        } else {
            //Authenticate User
            
            NetworkManager.shared.signup(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] result, error in
                if error != nil {
                    self!.showAlert(title: "Failed", message: error!.localizedDescription)
                } else {
                    //Store Data in Firestore DB
                    
                    let content: [String: Any] = ["username": self!.userNameTextField.text!,
                                                  "uid": result!.user.uid]
                    NetworkManager.shared.addUser(collectionName: "users",data: content)
                    
                    self!.navigateHomeScreen()
                }
            }
        }
        
    }
}
