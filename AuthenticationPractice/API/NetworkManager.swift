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
        database.collection("notes").addDocument(data: note)
    }
    
    func getNote(completion: @escaping([NoteItem]) -> Void) {
//        let db = Firestore.firestore()
        guard let uid = NetworkManager.shared.getUID() else { return }
        
        database.collection("notes").whereField("user", isEqualTo: uid).getDocuments { snapshot, error in
            var notes: [NoteItem] = []
            
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
                let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                
                let newNote = NoteItem(id: id, title: title, note: note, user: user, date: date)
                notes.append(newNote)
            }
            completion(notes)
//            print(noteList)
        }
    }
    
    func updateNote(note: NoteItem) {

        database.collection("notes").document(note.id!).updateData(["title": note.title, "note": note.note]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteNote(note: NoteItem) {
        database.collection("notes").document(note.id!).delete { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addUser(collectionName: String, data: [String: Any]) {
//        let db = Firestore.firestore()
        
        database.collection(collectionName).document(getUID()!).setData(data)
    }
    
    func getUser() {
        
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
