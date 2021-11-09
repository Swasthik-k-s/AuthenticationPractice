//
//  ReminderViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 09/11/21.
//

import UIKit

class ReminderViewController: UIViewController {

    var delegate: MenuDelegate?
    var remindNotes: [NoteItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureScreen()
        fetchRemindNotes()
        // Do any additional setup after loading the view.
    }

    func fetchRemindNotes() {
        NetworkManager.shared.fetchRemindNotes { result in
            switch result {
                
            case .success(let notes):
                self.remindNotes = notes
                print("Remind Notes Count", self.remindNotes.count)
            case .failure(let error):
                self.showAlert(title: "Error", message: "Failed to load remind Notes")
            }
        }
    }
    
    func configureNavigation() {
        
        navigationItem.title = menuItemConstants.reminder
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageConstants.menu), style: .plain, target: self, action: #selector(handleMenu))
    }
    
    @objc func handleMenu() {
        delegate?.menuHandler()
    }
}
