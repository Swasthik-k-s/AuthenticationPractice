//
//  AddItemViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 26/10/21.
//

import UIKit

class AddItemViewController: UIViewController {
    
    var noteArray = [NoteItem]()
    var isNew: Bool = true
    var note: NoteItem?
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var noteField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScreen()
        
        if !isNew {
            loadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func configureScreen() {
        
        navigationItem.title = isNew ? "ADD NOTE" : "EDIT NOTE"
        
    }
    
    func loadData() {
        titleField.text = note?.title
        noteField.text = note?.note
        
    }
    
    @IBAction func savePressed() {
        if titleField.text == "" || noteField.text == "" {
            showAlert(title: "Invalid", message: "Title or Note cannot be Empty")
        } else if isNew {
            
            let content: [String: Any] = ["title": titleField.text!,
                                          "note": noteField.text!,
                                          "user": NetworkManager.shared.getUID()!,
                                          "date": Date()]
            
            NetworkManager.shared.addNote(note: content)
            
            navigationController?.popViewController(animated: true)
        } else {
            note?.title = titleField.text!
            note?.note = noteField.text!
            
//            NetworkManager.shared.updateNote(note: note!)
        }
    }
    
    @IBAction func clearPressed() {
        titleField.text = ""
        noteField.text = ""
    }
}
