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
        
        configureScreen()
        navigationItem.title = isNew ? "ADD NOTE" : "EDIT NOTE"

        if !isNew {
            configureUI()
            loadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: note!.isArchive ?  imageConstants.unarchive : imageConstants.archive, style: .plain, target: self, action: #selector(archiveNote))
    }
    
    @objc func archiveNote() {
        note!.isArchive = !note!.isArchive
        DatabaseManager.shared.updateNote(note: note!)
        navigationController?.popViewController(animated: true)
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
                                   isArchive: false,
                                   date: Date())
            
            let realmNote = RealmNote()
            realmNote.title = titleField.text!
            realmNote.note = noteField.text!
            realmNote.user = NetworkManager.shared.getUID()!
            realmNote.date = Date()
            
            DatabaseManager.shared.addNote(note: newNote.dictionary)
            
            navigationController?.popViewController(animated: true)
        } else {
            note?.title = titleField.text!
            note?.note = noteField.text!
            
            DatabaseManager.shared.updateNote(note: note!)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clearPressed() {
        titleField.text = ""
        noteField.text = ""
    }
}
