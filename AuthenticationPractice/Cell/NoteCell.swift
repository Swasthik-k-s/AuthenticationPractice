//
//  NoteCell.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 27/10/21.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var noteText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var noteDelete: UIButton!
    
    var currentNote: NoteItem?
    var delegate: DeleteCellDelegate?
    
    @IBAction func deletePressed(_ sender: Any) {
        delegate?.deleteNote(note: currentNote!)
        
//        let alert = UIAlertController(title: "Delete \(currentNote?.title)", message: "Are you Sure", preferredStyle: .alert)
//
//        let button = UIAlertAction(title: "Delete", style: .default) { (buttonclick) in
//
//        }
//
//        let cancel = UIAlertAction(title: "Cancel", style: .default) { (cancelclick) in
//        }
//
//        alert.addAction(cancel)
//        alert.addAction(button)
//
//        HomeViewController().present(alert, animated: true, completion: nil)
        
        
    }
}

