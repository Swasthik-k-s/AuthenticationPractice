//
//  NetworkManager.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 20/10/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct NetworkManager {
    static let shared = NetworkManager()
    
    func login(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password,completion: completion)
    }
    
    func signup(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func getUID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func writeDB(documentName: String, data: [String: Any]) {
        let db = Firestore.firestore()
        
        db.collection(documentName).document(getUID()!).setData(data)
    }
    
    func signout() -> Bool {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            return true
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        return false
    }
}
