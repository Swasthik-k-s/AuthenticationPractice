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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // Validate the user inputs
    // returns nil if validated else error message
    func validateUser(username: String?, email: String?, password: String?) -> String? {
        if username == "" ||
            email == "" ||
            password == "" {
            
            let invalidText: String = "Please fill all the Fields"
            return invalidText
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
                    NetworkManager.shared.writeDB(documentName: "users",data: content)
                    
                    self!.navigateHomeScreen()
                }
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
