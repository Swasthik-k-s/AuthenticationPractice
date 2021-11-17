//
//  ReminderViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 09/11/21.
//

import UIKit

class ReminderViewController: UIViewController {

    let cellIdentifier = "reminderCell"
    var delegate: MenuDelegate?
    var remindNotes: [NoteItem] = []
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        fetchRemindNotes()
        configureCollectionView()
        configureScreen()
        
        // Do any additional setup after loading the view.
    }

    func fetchRemindNotes() {
        NetworkManager.shared.fetchRemindNotes { result in
            switch result {
                
            case .success(let notes):
                self.remindNotes = notes
                print("Remind Notes Count", self.remindNotes.count)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ReminderCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func configureNavigation() {
        
        navigationItem.title = menuItemConstants.reminder
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageConstants.menu), style: .plain, target: self, action: #selector(handleMenu))
    }
    
    @objc func handleMenu() {
        delegate?.menuHandler()
    }
}

extension ReminderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return remindNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ReminderCell
        
        cell.layer.cornerRadius = 10
        cell.backgroundColor = colorConstants.black1
        
        let note = remindNotes[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        
        let reminderdDate = note.reminder
        
        cell.titleLabel.text = note.title
        cell.noteLabel.text = note.note
        
        cell.remindDateLabel.text = dateFormatter.string(from: reminderdDate ?? Date())
        cell.remindTimeLabel.text = timeFormatter.string(from: reminderdDate ?? Date())
        cell.currentNote = note
        cell.delegate = self
        
        return cell
    }
}

extension ReminderViewController: UICollectionViewDelegate {
    
}

extension ReminderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ReminderViewController: RemoveReminderDelegate {
    func removeReminder(note: NoteItem) {
        
        var updateNote = note
        
        let removeReminder = {
            updateNote.reminder = nil
            DatabaseManager.shared.updateNote(note: updateNote)
            self.fetchRemindNotes()
        }
        
        showAlertWithCancel(title: "Remove Reminder for " + note.title, message: "Are you Sure", buttonText: "Remove", buttonAction: removeReminder)
    }
    
}
