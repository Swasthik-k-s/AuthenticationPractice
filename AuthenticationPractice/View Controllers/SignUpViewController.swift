//
//  SignUpViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 19/10/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

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
    func validateUser() -> String? {
        if userNameTextField.text == "" ||
            emailTextField.text == "" ||
            passwordTextField.text == "" {
            
            let invalidText: String = "Please fill all the Fields"
            return invalidText
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        let error = validateUser()
        
        if error != nil {
            showAlert(title: "Invalid", message: error!)
            
        } else {
            //Authenticate User
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                
                if error != nil {
                    self.showAlert(title: "Error", message: error!.localizedDescription)
                } else {
                    
                    // Store Username in Firestore Database
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(Auth.auth().currentUser!.uid).setData([
                        "username": self.userNameTextField.text!,
                        "uid": result!.user.uid
                    ])
                    
                        if error != nil {
                            self.showAlert(title: "Failed", message: "Failed to Store the Data in Database")
                        }
                    
                    
                    //Navigate to Home Screen from Reusable File
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
