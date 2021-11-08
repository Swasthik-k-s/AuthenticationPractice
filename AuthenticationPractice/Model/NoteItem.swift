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
}
