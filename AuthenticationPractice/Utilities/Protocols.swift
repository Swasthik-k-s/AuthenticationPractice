//
//  Protocols.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 24/10/21.
//

//protocol HomeControllerDelegate {
//    func handleMenuToggle()
//}

protocol MenuDelegate {
    func menuHandler()
    func didSelectMenu(menuItem: String)
}

protocol DeleteCellDelegate {
    func deleteNote(note: NoteItem)
}

protocol RemoveReminderDelegate {
    func removeReminder(note: NoteItem)
}
