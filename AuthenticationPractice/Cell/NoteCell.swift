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
    }
}

