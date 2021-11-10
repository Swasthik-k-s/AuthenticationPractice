//
//  NetworkManager.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 20/10/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseStorage
import UIKit

var lastDoc: QueryDocumentSnapshot?
var fetchingMoreNotes = false

struct NetworkManager {
    static let shared = NetworkManager()
    
    let database = Firestore.firestore()
    
    func login(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password,completion: completion)
    }
    
    func signup(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func getUID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func addNote(note: [String: Any]) {
        guard let uid = NetworkManager.shared.getUID() else { return }
        database.collection("users").document(uid).collection("notes").addDocument(data: note)
//        database.collection("notes").addDocument(data: note)
    }
    
//    func getNote(completion: @escaping([NoteItem]) -> Void) {
//        //        let db = Firestore.firestore()
//        guard let uid = NetworkManager.shared.getUID() else { return }
//
//        database.collection("users").document(uid).collection("notes").order(by: "date").getDocuments { snapshot, error in
//            var notes: [NoteItem] = []
//
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            guard let snapshot = snapshot else { return }
//
//            for doc in snapshot.documents {
//                let data = doc.data()
//                let id = doc.documentID
//                let title = data["title"] as? String ?? ""
//                let note = data["note"] as? String ?? ""
//                let user = data["user"] as? String ?? ""
//                let isArchive = data["isArchive"] as? Bool ?? false
//                let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
//
//                let newNote = NoteItem(id: id, title: title, note: note, user: user, isArchive: isArchive, date: date)
//                notes.append(newNote)
//            }
//            completion(notes)
//            //            print(noteList)
//        }
//    }
    
    func fetchMoreNotes(archivedNotes: Bool, completion: @escaping([NoteItem]) -> Void) {
        
        fetchingMoreNotes = true
        print("Inside Fetch More Note")
        guard let uid = NetworkManager.shared.getUID() else { return }
        guard let lastDocument = lastDoc else { return }
        
        database.collection("users").document(uid).collection("notes").whereField("isArchive", isEqualTo: archivedNotes).start(afterDocument: lastDocument).limit(to: 10).getDocuments { snapshot, error in
            var notes: [NoteItem] = []
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            for doc in snapshot.documents {
                let data = doc.data()
                let id = doc.documentID
                let title = data["title"] as? String ?? ""
                let note = data["note"] as? String ?? ""
                let user = data["user"] as? String ?? ""
                let isArchive = data["isArchive"] as? Bool ?? false
                let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                
                let newNote = NoteItem(id: id, title: title, note: note, user: user, isArchive: isArchive, date: date)
                notes.append(newNote)
            }
            lastDoc = snapshot.documents.last
            print("|||||||||||||||||||||||||||||||||||||")
            fetchingMoreNotes = false
            print(notes)
            completion(notes)
        }
    }
    
    func fetchNotes(archivedNotes: Bool, completion: @escaping(Result<[NoteItem], Error>) -> Void) {
        
        guard let uid = NetworkManager.shared.getUID() else { return }
        
        database.collection("users").document(uid).collection("notes").whereField("isArchive", isEqualTo: archivedNotes).limit(to: 10).getDocuments { snapshot, error in
            var notes: [NoteItem] = []
            
            if let error = error {
                completion(.failure(error))
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
                let isArchive = data["isArchive"] as? Bool ?? false
                let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                
                
                let newNote = NoteItem(id: id, title: title, note: note, user: user, isArchive: isArchive, date: date)
                notes.append(newNote)
            }
            lastDoc = snapshot.documents.last
//            completion(notes, nil)
            completion(.success(notes))
        }
    }
    
    
    func fetchRemindNotes(completion: @escaping(Result<[NoteItem], Error>) -> Void) {
        
        guard let uid = NetworkManager.shared.getUID() else { return }
//        let nilValue: Date?
        let nilValue: Date? = nil
        
        database.collection("users").document(uid).collection("notes").whereField("reminder", isNotEqualTo: nilValue).limit(to: 10).getDocuments { snapshot, error in
            var notes: [NoteItem] = []
            
            if let error = error {
                completion(.failure(error))
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
                let isArchive = data["isArchive"] as? Bool ?? false
                let reminder = (data["reminder"] as? Timestamp)?.dateValue() ?? Date()
                let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                
                let newNote = NoteItem(id: id, title: title, note: note, user: user, isArchive: isArchive, reminder: reminder, date: date)
                notes.append(newNote)
            }
            lastDoc = snapshot.documents.last
//            completion(notes, nil)
            completion(.success(notes))
        }
    }
    
    func updateNote(note: NoteItem) {
        guard let uid = NetworkManager.shared.getUID() else { return }
        
        database.collection("users").document(uid).collection("notes").document(note.id!).updateData(note.dictionary) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteNote(note: NoteItem) {
        guard let uid = NetworkManager.shared.getUID() else { return }
        
        database.collection("users").document(uid).collection("notes").document(note.id!).delete { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addUser(collectionName: String, data: [String: Any]) {
        //        let db = Firestore.firestore()
        
        database.collection(collectionName).document(getUID()!).setData(data)
    }
    
    func getUser(completion: @escaping(Result<[String: Any], Error>) -> Void) {
        guard let uid = NetworkManager.shared.getUID() else { return }
        database.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            let data = snapshot.data()
            print(data!)
            completion(.success(data!))
        }
    }
    
    func downloadImage(fromURL urlString: String, completion: @escaping(UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            let image = UIImage(data: data)
            completion(image)
        }
        
        task.resume()
    }
    
    func signout() -> Bool {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance.signOut()
            return true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        return false
    }
}
