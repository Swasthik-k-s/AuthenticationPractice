//
//  ReminderCell.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 09/11/21.
//

import UIKit

class ReminderCell: UICollectionViewCell {
    
    var currentNote: NoteItem?
    var delegate: RemoveReminderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = .yellow
        return title
    }()
    
    let noteLabel: UILabel = {
        let note = UILabel()
        note.font = UIFont.systemFont(ofSize: 16)
        note.textColor = .white
        return note
    }()
    
    let remindDateLabel: UILabel = {
        let date = UILabel()
        date.textColor = .white
        return date
    }()
    
    let remindTimeLabel: UILabel = {
        let time = UILabel()
        time.textColor = .white
        return time
    }()
    
    let deleteButton: UIButton = {
        let delete = UIButton()
        delete.setImage(UIImage(systemName: imageConstants.delete), for: .normal)
        delete.tintColor = .red
        delete.addTarget(self, action: #selector(removeReminder), for: .touchUpInside)
        return delete
    }()
    
    let stackView1: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.fill
        return stack
    }()
    let stackView2: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = NSLayoutConstraint.Axis.vertical
        return stack
    }()
    
    @objc func removeReminder() {
        delegate?.removeReminder(note: currentNote!)
    }
    
    func configureCell() {
        layer.borderColor = UIColor.yellow.cgColor
        layer.borderWidth = 2
        
        stackView1.addArrangedSubview(titleLabel)
        stackView1.addArrangedSubview(noteLabel)
        stackView2.addArrangedSubview(remindDateLabel)
        stackView2.addArrangedSubview(remindTimeLabel)

        addSubview(stackView1)
        addSubview(stackView2)

        addSubview(deleteButton)
        
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        remindDateLabel.translatesAutoresizingMaskIntoConstraints = false
        remindTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            stackView1.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            stackView1.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -200),

            stackView2.rightAnchor.constraint(equalTo: deleteButton.leftAnchor,constant: -50),
            stackView2.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
                        deleteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            deleteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
}
