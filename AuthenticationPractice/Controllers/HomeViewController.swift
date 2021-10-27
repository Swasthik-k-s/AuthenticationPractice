//
//  HomeViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 19/10/21.
//

import UIKit
import GoogleSignIn
import FirebaseFirestore

class HomeViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var noteCollectionView: UICollectionView!
    var delegate: MenuDelegate?
    var noteList: [NoteItem] = []
    var testArray: [String] = ["a","b"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScreen()
        getData()
        
    }
    
    func getData() {
        let db = Firestore.firestore()
        
        db.collection("notes").whereField("user", isEqualTo: NetworkManager.shared.getUID()!).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            for doc in snapshot.documents {
                let data = doc.data()
                let id = doc.documentID
                let title = data["title"] as? String ?? ""
                let note = data["note"] as? String ?? ""
                let user = data["user"] as? String ?? ""
                let date = data["date"] as? Date ?? Date()
                
                let newNote = NoteItem(id: id, title: title, note: note, user: user, date: date)
                self.noteList.append(newNote)
                
            }
            self.noteCollectionView.reloadData()
        }
        
        print(self.noteList)
    }
    
    func configureScreen() {
        let itemSize = UIScreen.main.bounds.width/2 - 14
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        noteCollectionView.collectionViewLayout = layout
        
        noteCollectionView.backgroundColor = .clear
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1.0)
        navigationItem.title = "HOME"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(handleMenu))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(addPressed))
    }
    
    @objc func addPressed() {
        let addView = storyboard!.instantiateViewController(withIdentifier: "AddVC") as! AddItemViewController
        print(noteList)
        navigationController?.pushViewController(addView, animated: true)
        //        addView.modalPresentationStyle = .fullScreen
        //        present(addView, animated: true, completion: nil)
    }
    
    @objc func handleMenu() {
        //        print("Menu CLicked done")
        delegate?.menuHandler()
    }
    
    
    //MARK: Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(noteList.count)
        return noteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteCell", for: indexPath) as! NoteCell
        cell.titleText.text = noteList[indexPath.row].title
        cell.noteText.text = noteList[indexPath.row].note
        return cell
    }
    
}


