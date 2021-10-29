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
    var isGridView: Bool = true
    var viewModeButton: UIBarButtonItem = UIBarButtonItem()
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    func getData() {
        NetworkManager.shared.getNote { notes in
            self.noteList = notes
            DispatchQueue.main.async {
                self.noteCollectionView.reloadData()
            }
        }
    }
    
    func configureNavigationBar() {
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1.0)
        navigationItem.title = "HOME"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(handleMenu))
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(addPressed))
        
        viewModeButton = UIBarButtonItem(image: UIImage(systemName: imageConstants.lineView), style: .plain, target: self, action: #selector(toggleCollectionView))
        
        navigationItem.rightBarButtonItems = [addButton, viewModeButton]
        
    }
    
    func configureCollectionView() {
        let itemSize = UIScreen.main.bounds.width/2 - 12
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
//        noteCollectionView.layer.cornerRadius = 10
        noteCollectionView.collectionViewLayout = layout
        noteCollectionView.backgroundColor = .clear
    }
    
    @objc func toggleCollectionView() {
        isGridView = !isGridView
        let gridSize = UIScreen.main.bounds.width/2 - 12
        let lineSize = UIScreen.main.bounds.width - 24
        
        if isGridView {
            viewModeButton.image = UIImage(systemName: imageConstants.lineView)
            
            layout.itemSize = CGSize(width: gridSize, height: gridSize)
            noteCollectionView.collectionViewLayout = layout
        
        } else {
            viewModeButton.image = UIImage(systemName: imageConstants.gridView)
            
            layout.itemSize = CGSize(width: lineSize, height: gridSize)
            noteCollectionView.collectionViewLayout = layout
        }
    }
    
    @objc func addPressed() {
        let addView = storyboard!.instantiateViewController(withIdentifier: "AddVC") as! AddItemViewController
        print(noteList)
        
        addView.isNew = true
        
        navigationController?.pushViewController(addView, animated: true)
    }
    
    @objc func handleMenu() {
        delegate?.menuHandler()
    }
    
    @objc func deleteNote(_ sender: UIButton) {
        let note = self.noteList[sender.tag]
        
        let deleteNote = {
            NetworkManager.shared.deleteNote(note: note)
            self.noteList.remove(at: sender.tag)
            self.noteCollectionView.reloadData()
        }
        
        showAlertWithCancel(title: "Delete " + note.title, message: "Are you Sure", buttonText: "Delete", buttonAction: deleteNote)
        
//        let deleteNote = noteList[sender.tag]
//        print(deleteNote.title)
//        NetworkManager.shared.deleteNote(note: deleteNote)
//        noteList.remove(at: sender.tag)
//        noteCollectionView.reloadData()
        print("Deleted")
    }
    
    
    //MARK: Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(noteList.count)
        return noteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteCell", for: indexPath) as! NoteCell
        
        let date = noteList[indexPath.row].date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"

        cell.titleText.text = noteList[indexPath.row].title
        cell.noteText.text = noteList[indexPath.row].note
        cell.dateText.text = dateFormatter.string(from: date)
        cell.timeText.text = timeFormatter.string(from: date)
        
        cell.noteDelete.tag = indexPath.row
        cell.noteDelete.addTarget(self, action: #selector(deleteNote), for: .touchUpInside)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let addView = storyboard!.instantiateViewController(withIdentifier: "AddVC") as! AddItemViewController
        
        addView.isNew = false
        addView.note = noteList[indexPath.row]
        
        navigationController?.pushViewController(addView, animated: true)
    }
    
}


