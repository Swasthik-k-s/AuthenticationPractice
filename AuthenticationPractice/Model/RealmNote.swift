//
//  realmNote.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 31/10/21.
//

import UIKit
import RealmSwift

class RealmNote: Object {
    @objc dynamic var title: String?
    @objc dynamic var note: String?
    @objc dynamic var user: String?
    @objc dynamic var date: Date?
    
}
