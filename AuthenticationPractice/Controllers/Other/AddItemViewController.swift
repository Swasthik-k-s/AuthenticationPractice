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
    
    var remindTime: Date? = nil
    
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
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageConstants.remind, style: .plain, target: self, action: #selector(navigatePicker))
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
        
        navigationController?.pushViewController(pickerVC, animated: true)
        
        pickerVC.completion = { remindDate in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                
                self.remindTime = remindDate
            }
        }
    }
    
    func accessNotification() {
        
        guard let remindTime = remindTime else  { return }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.setNotification(remindDate: remindTime)
            } else {
                self.showAlert(title: "Failed", message: "Failed to access Notification")
            }
        }
    }
    
    func setNotification(remindDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Note Remainder for \(titleField.text)"
        content.sound = .default
        content.body = noteField.text
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: remindDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                self.showAlert(title: "Failed", message: "Error")
            }
        }
    }
    
    func loadData() {
        titleField.text = note?.title
        noteField.text = note?.note
        remindTime = note?.reminder
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
                                   reminder: remindTime,
                                   date: Date())
            
            accessNotification()
//            let realmNote = RealmNote()
//            realmNote.title = titleField.text!
//            realmNote.note = noteField.text!
//            realmNote.user = NetworkManager.shared.getUID()!
//            realmNote.date = Date()
            
            DatabaseManager.shared.addNote(note: newNote.dictionary)
            
            navigationController?.popViewController(animated: true)
        } else {
            note?.title = titleField.text!
            note?.note = noteField.text!
            note?.reminder = remindTime
            
            accessNotification()
            
            DatabaseManager.shared.updateNote(note: note!)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clearPressed() {
        titleField.text = ""
        noteField.text = ""
    }
}
