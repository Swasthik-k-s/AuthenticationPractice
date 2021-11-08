//
//  HomeViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 19/10/21.
//

import UIKit
import GoogleSignIn
import FirebaseFirestore
import RealmSwift

class HomeViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var noteCollectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    var delegate: MenuDelegate?
    var noteList: [NoteItem] = []
    var searchedNote: [NoteItem] = []
    let searchController = UISearchController(searchResultsController: nil)
    var hasMoreNotes = true
    private var inSearchMode: Bool {
        return !searchController.searchBar.text!.isEmpty
    }
    
    var isGridView: Bool = true
    var viewModeButton: UIBarButtonItem = UIBarButtonItem()
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureCollectionView()
        configureScreen()
        configureSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hasMoreNotes = true
        if NetworkManager.shared.getUID() != nil {
            getData()
        }
        self.noteCollectionView.reloadData()
    }
    
    func configureNavigationBar() {
        
        navigationItem.title = menuItemConstants.home
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageConstants.menu), style: .plain, target: self, action: #selector(handleMenu))
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: imageConstants.add), style: .plain, target: self, action: #selector(addPressed))
        
        viewModeButton = UIBarButtonItem(image: UIImage(systemName: imageConstants.lineView), style: .plain, target: self, action: #selector(toggleCollectionView))
        
        navigationItem.rightBarButtonItems = [addButton, viewModeButton]
    }
    
    func configureCollectionView() {
        let itemSize = UIScreen.main.bounds.width/2 - 12
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        noteCollectionView.collectionViewLayout = layout
        noteCollectionView.backgroundColor = .clear
    }
    
    func configureSearch() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Note"
    }
    
    func updateCollectionView(notes: [NoteItem]) {
        if notes.count < 10 {
            self.hasMoreNotes = false
        }
        
        self.noteList = notes
        DispatchQueue.main.async {
            self.handleEmptyState(array: self.noteList)
            self.noteCollectionView.reloadData()
        }
    }
    
    func getData() {
        
        NetworkManager.shared.fetchNotes(archivedNotes: false) { result in
            switch result {
                
            case .success(let notes):
                self.updateCollectionView(notes: notes)

            case .failure(let error):
                self.showAlert(title: "Error while Fetching Notes", message: error.localizedDescription)
            }
        }
        
//        NetworkManager.shared.fetchNotes { notes, error in
//            if let error = error {
//                self.showAlert(title: "Error while Fetching Notes", message: error.localizedDescription)
//                return
//            }
//            guard let notes = notes else {
//                return
//            }
//
//            if notes.count < 10 {
//                self.hasMoreNotes = false
//            }
//
//            self.noteList = notes
//            DispatchQueue.main.async {
//                self.handleEmptyState(array: self.noteList)
//                self.noteCollectionView.reloadData()
//            }
//        }
        
//        NetworkManager.shared.fetchNotes { notes, error in
//            print(notes!.count)
//            if notes!.count < 10 {
//                self.hasMoreNotes = false
//            }
//            self.noteList = notes
//            DispatchQueue.main.async {
//                self.handleEmptyState(array: self.noteList)
//                self.noteCollectionView.reloadData()
//            }
            
//        }
        
        //Fetch firebase notes
        //        NetworkManager.shared.getNote { notes in
        //            self.noteList = notes
        //
        //            //Show firebase content in collection view
        //            DispatchQueue.main.async {
        //                self.handleEmptyState(array: self.noteList)
        //                self.noteCollectionView.reloadData()
        //            }
        //        }
    }
    
    func handleEmptyState(array: [NoteItem]) {
        if array.count == 0 {
            emptyLabel.isHidden = false
            noteCollectionView.isHidden = true
        } else {
            emptyLabel.isHidden = true
            noteCollectionView.isHidden = false
        }
    }
    
    //OBJC Functions
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
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "url not found")
        
        let addView = storyboard!.instantiateViewController(withIdentifier: "AddVC") as! AddItemViewController
        
        addView.isNew = true
        
        navigationController?.pushViewController(addView, animated: true)
    }
    
    @objc func handleMenu() {
        delegate?.menuHandler()
    }
    
    //MARK: Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? searchedNote.count : noteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteCell", for: indexPath) as! NoteCell
        cell.layer.cornerRadius = 10
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        
        let note = inSearchMode ? searchedNote[indexPath.row] : noteList[indexPath.row]
        
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
        
        addView.note = inSearchMode ? searchedNote[indexPath.row] : noteList[indexPath.row]
        
        navigationController?.pushViewController(addView, animated: true)
    }
}

//MARK: DeleteCellDelegate
extension HomeViewController: DeleteCellDelegate {
    
    func deleteNote(note: NoteItem) {
        
        let deleteNote = {
            DatabaseManager.shared.deleteNote(note: note)
            self.searchController.isActive = false
            self.getData()
        }
        
        showAlertWithCancel(title: "Delete " + note.title, message: "Are you Sure", buttonText: "Delete", buttonAction: deleteNote)
    }
}

//MARK: UISearchResultsUpdating, UISearchBarDelegate
extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        
        if inSearchMode {
            searchedNote.removeAll()
            
            for note in noteList {
                if note.title.lowercased().contains(searchText.lowercased()) || note.note.lowercased().contains(searchText.lowercased()) {
                    searchedNote.append(note)
                }
            }
            handleEmptyState(array: searchedNote)
        }
        noteCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        handleEmptyState(array: noteList)
        noteCollectionView.reloadData()
    }
}

//MARK: UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            print("??????????")
            
            guard hasMoreNotes else { return }
            print(fetchingMoreNotes)

            guard !fetchingMoreNotes else {
                print("fetching more note completed")
                return
            }

            NetworkManager.shared.fetchMoreNotes { notes in
                if notes.count < 10 {
                    self.hasMoreNotes = false
                }
                self.noteList.append(contentsOf: notes)
                print(self.noteList.count)
                self.noteCollectionView.reloadData()
            }
        }
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let position = scrollView.contentOffset.y
//
//        print("Position \(position)")
//        print("number \(noteCollectionView.contentSize.height - scrollView.frame.size.height - 100)")
//        print("collection view height \(noteCollectionView.contentSize.height)")
//
//        if position > noteCollectionView.contentSize.height - scrollView.frame.size.height - 100 {
            

//        }
//
//    }
}


