//
//  HomeViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 19/10/21.
//

import UIKit
import GoogleSignIn
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    var delegate: MenuDelegate?
    var noteList: [NoteItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScreen()
//        getData()
        
    }
    
    func getData() {
        let db = Firestore.firestore()
        
        db.collection("notes").addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            for data in snapshot!.documentChanges {
                if data.type == .added {
                    let noteId = data.document.get("noteId") as! String
                    let title = data.document.get("title") as! String
                    let note = data.document.get("note") as! String
                    let user = data.document.get("user") as! String
                    let date = data.document.get("date") as! Timestamp
                    
                    let format = DateFormatter()
                    format.dateFormat = "dd-MM-YY hh:mm a"
                    let dateString = format.string(from: date.dateValue())
                    
                    self.noteList.append(NoteItem(noteId: noteId, title: title, note: note, user: user, date: dateString))
                }
                
            }
        }
    }
    
    func configureScreen() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1.0)
        navigationItem.title = "HOME"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(handleMenu))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(addPressed))
    }
    
    @objc func addPressed() {
        let addView = storyboard!.instantiateViewController(withIdentifier: "AddVC") as! AddItemViewController
        navigationController?.pushViewController(addView, animated: true)
//        addView.modalPresentationStyle = .fullScreen
//        present(addView, animated: true, completion: nil)
    }
    
    @objc func handleMenu() {
//        print("Menu CLicked done")
        delegate?.menuHandler()
    }
    
//    @IBAction func logoutPressed(_ sender: Any) {
//        let isSignedOut = NetworkManager.shared.signout()
//
//        if isSignedOut {
//            navigateLoginScreen()
//        }
//    }
    
}


