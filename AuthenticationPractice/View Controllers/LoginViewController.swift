//
//  LoginViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 19/10/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func validateUser() -> String? {
        if emailTextField.text == "" ||
            passwordTextField.text == "" {
            
            let invalidText: String = "Please fill all the Fields"
            return invalidText
        }
        return nil
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        let error = validateUser()
        
        if error != nil {
            showAlert(title: "Invalid", message: error!)
        } else {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { result, error in
                
                if error != nil {
                    self.showAlert(title: "Invalid", message: error!.localizedDescription)
                } else {
                    self.navigateHomeScreen()
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
