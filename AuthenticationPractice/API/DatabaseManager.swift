//
//  DatabaseManager.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 01/11/21.
//

import Foundation
import UIKit

struct DatabaseManager {
    static let shared = DatabaseManager()
    
    func addNote(note: [String: Any], realmNote: RealmNote) {
        NetworkManager.shared.addNote(note: note)
//        PersistentManager.shared.addNote(note: realmNote)
    }
    
    func updateNote(note: NoteItem, title: String, description: String) {
        NetworkManager.shared.updateNote(note: note)
//        PersistentManager.shared.updateNote(note: realmNote, title: title, description: description)
    }
    
    func deleteNote(note: NoteItem) {
        NetworkManager.shared.deleteNote(note: note)
//        if realmNote.title != "" {
////            PersistentManager.shared.deleteNote(note: realmNote)
//        }
        
    }
    
}

