//
//  ArchiveViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 08/11/21.
//

import UIKit

class ArchiveViewController: UIViewController {
    
    @IBOutlet weak var noteCollectionView: UICollectionView!
    
    let layout = UICollectionViewFlowLayout()
    var delegate: MenuDelegate?
    var noteList: [NoteItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        configureNavigation()
        configureCollectionView()
        configureScreen()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("appeared")
        if NetworkManager.shared.getUID() != nil {
            getData()
        }
//        self.noteCollectionView.reloadData()
    }
    
    func configureNavigation() {
        
        navigationItem.title = menuItemConstants.archive
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageConstants.menu), style: .plain, target: self, action: #selector(handleMenu))
    }
    
    func configureCollectionView() {
        let itemSize = UIScreen.main.bounds.width/2 - 12
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        noteCollectionView.collectionViewLayout = layout
        noteCollectionView.backgroundColor = .clear
        noteCollectionView.delegate = self
        noteCollectionView.dataSource = self
    }
    
    func getData() {
        print("INSIDE GET DATA")
        NetworkManager.shared.fetchNotes(archivedNotes: true) { result in
            switch result {
                
            case .success(let notes):
                self.updateCollectionView(notes: notes)

            case .failure(let error):
                self.showAlert(title: "Error while Fetching Notes", message: error.localizedDescription)
            }
        }
    }
    
    func updateCollectionView(notes: [NoteItem]) {
        print("INSIDE update")
        self.noteList = notes
        print(noteList.count)
        DispatchQueue.main.async {
            self.noteCollectionView.reloadData()
        }
    }
    
    @objc func handleMenu() {
        delegate?.menuHandler()
    }
}

extension ArchiveViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(noteList.count)
        return noteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteCell", for: indexPath) as! NoteCell
        cell.layer.cornerRadius = 10
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        
        let note = noteList[indexPath.row]
        
        let date = note.date
        
        cell.titleText.text = note.title
        cell.noteText.text = note.note
        cell.dateText.text = dateFormatter.string(from: date)
        cell.timeText.text = timeFormatter.string(from: date)
        cell.currentNote = note
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let addView = storyboard!.instantiateViewController(withIdentifier: StoryBoardConstants.addNoteVCIdentifier) as! AddItemViewController
        
        addView.isNew = false
        
        addView.note = noteList[indexPath.row]
        
        navigationController?.pushViewController(addView, animated: true)
    }
}

extension ArchiveViewController: DeleteCellDelegate {
    
    func deleteNote(note: NoteItem) {
        
        let deleteNote = {
            DatabaseManager.shared.deleteNote(note: note)
            self.getData()
        }
        
        showAlertWithCancel(title: "Delete " + note.title, message: "Are you Sure", buttonText: "Delete", buttonAction: deleteNote)
    }
}
