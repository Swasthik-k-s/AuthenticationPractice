//
//  AddItemViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 26/10/21.
//

import UIKit
import UserNotifications

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
        navigationItem.title = isNew ? "Add Note" : "Edit Note"

        if !isNew {
            configureUI()
            loadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        navigationItem.backButtonTitle = "Back"
        let archiveButton = UIBarButtonItem(image: note!.isArchive ?  imageConstants.unarchive : imageConstants.archive, style: .plain, target: self, action: #selector(archiveNote))
        
        let remindButton = UIBarButtonItem(image: imageConstants.remind, style: .plain, target: self, action: #selector(navigatePicker))
        
        navigationItem.rightBarButtonItems = [archiveButton, remindButton]
    }
    
    @objc func archiveNote() {
        note!.isArchive = !note!.isArchive
        DatabaseManager.shared.updateNote(note: note!)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func navigatePicker() {
        let pickerVC = (storyboard!.instantiateViewController(withIdentifier: StoryBoardConstants.dateTimePickerVCIdentifier)) as! DateTimePickerViewController
        
        pickerVC.completion = { remindDate in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        self.setDate(remindDate: remindDate)
                    } else {
                        self.showAlert(title: "Failed", message: "Failed to set the Remainder")
                    }
                }
            }
        }
        navigationController?.pushViewController(pickerVC, animated: true)
        
        
    }
    
    func setDate(remindDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Note Remainder for \(note!.title)"
        content.sound = .default
        content.body = note!.note
        
        let targetDate = remindDate
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                self.showAlert(title: "Failed", message: "Error")
            }
        }
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
