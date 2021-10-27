//
//  AddItemViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 26/10/21.
//

import UIKit
import FirebaseFirestore

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var noteField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScreen()
        // Do any additional setup after loading the view.
    }
    
    //    let closeButton = UIButton()
    
    func configureScreen() {
        
        navigationItem.title = "ADD NOTE"
        
    }
    
    @IBAction func savePressed() {
        if titleField.text == "" || noteField.text == "" {
            showAlert(title: "Invalid", message: "Title or Note cannot be Empty")
        } else {
            
            let db = Firestore.firestore()
            let content: [String: Any] = ["title": titleField.text!,
                                          "note": noteField.text!, "user": NetworkManager.shared.getUID()!,
                                          "date": Date()]
            
            db.collection("notes").addDocument(data: content)
//            NetworkManager.shared.writeDB(collectionName: "notes",data: content)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clearPressed() {
        titleField.text = ""
        noteField.text = ""
    }
}
