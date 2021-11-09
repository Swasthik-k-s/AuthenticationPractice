//
//  NoteItem.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 27/10/21.
//

import FirebaseFirestore
import Foundation

struct NoteItem: Codable {
    var id: String?
    var title: String
    var note: String
    var user: String
    var isArchive: Bool
    var date: Date
    
    var dictionary: [String: Any] {
        return [
            "title": title,
            "note": note,
            "user": user,
            "isArchive": isArchive,
            "date": date
        ]
    }
    
//    init(dictionary: [String: Any]) {
//        let data = dictionary.data()
//        id = doc.documentID
//        title = data["title"] as? String ?? ""
//        note = data["note"] as? String ?? ""
//        user = data["user"] as? String ?? ""
//        isArchive = data["isArchive"] as? Bool ?? false
//        date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
//    }
}
