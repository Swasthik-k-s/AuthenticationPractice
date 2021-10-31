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
    var realmNote: RealmNote?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = isNew ? "ADD NOTE" : "EDIT NOTE"
        
        if !isNew {
            loadData()
            titleField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
            noteField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldChanged() {

        saveButton.isHidden = note?.title != titleField.text ||
        note?.note != noteField.text ? false : true
    }
    
    func loadData() {
        titleField.text = note?.title
        noteField.text = note?.note
        saveButton.setTitle("UPDATE", for: .normal)
        saveButton.isHidden = true
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
            
            NetworkManager.shared.addNote(note: newNote.dictionary)
            PersistentManager.shared.addNote(note: realmNote)
            
            navigationController?.popViewController(animated: true)
        } else {
            note?.title = titleField.text!
            note?.note = noteField.text!
            
            NetworkManager.shared.updateNote(note: note!)
            PersistentManager.shared.updateNote(note: realmNote!, title: titleField.text!, description: noteField.text!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clearPressed() {
        titleField.text = ""
        noteField.text = ""
    }
}
