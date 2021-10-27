//
//  NoteItem.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 27/10/21.
//

import FirebaseFirestore
import Foundation

struct NoteItem: Codable {
    var noteId: String
    var title: String
    var note: String
    var user: String
    var date: String
}
