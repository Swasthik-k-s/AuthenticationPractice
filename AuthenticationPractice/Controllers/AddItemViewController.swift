//
//  AddItemViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 26/10/21.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate {
    
    var noteArray = [NoteItem]()
    var isNew: Bool = true
    var note: NoteItem?
    var realmNote: RealmNote = RealmNote()
    
    @IBOutlet weak var titleField: UITextField!
//    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var noteField: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = isNew ? "ADD NOTE" : "EDIT NOTE"

        if !isNew {
            loadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        titleField.text = note?.title
        noteField.text = note?.note
        saveButton.setTitle("UPDATE", for: .normal)
    }
    
    @IBAction func savePressed() {
        if titleField.text == "" || noteField.text == "" {
            showAlert(title: "Invalid", message: "Title or Note cannot be Empty")
        } else if isNew {
            
            let newNote = NoteItem(title: titleField.text!,
                                   note: noteField.text!,
                                   user: NetworkManager.shared.getUID()!,
                                   date: Date())
            
            let realmNote = RealmNote()
            realmNote.title = titleField.text!
            realmNote.note = noteField.text!
            realmNote.user = NetworkManager.shared.getUID()!
            realmNote.date = Date()
            
            DatabaseManager.shared.addNote(note: newNote.dictionary, realmNote: realmNote)
            
            navigationController?.popViewController(animated: true)
        } else {
            note?.title = titleField.text!
            note?.note = noteField.text!
            
            DatabaseManager.shared.updateNote(note: note!, title: titleField.text!, description: noteField.text!)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clearPressed() {
        titleField.text = ""
        noteField.text = ""
    }
}
