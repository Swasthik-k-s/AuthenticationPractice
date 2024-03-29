//
//  DateTimePickerViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 08/11/21.
//

import UIKit

class DateTimePickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var completion: ((Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
        configureUI()
        
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        navigationItem.title = "Set Remainder"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done,  target: self, action: #selector(saveDate))
        datePicker.minimumDate = Date()
        datePicker.backgroundColor = .white
        datePicker.layer.cornerRadius = 30
    }
    
    @objc func closePicker() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveDate() {
        let remindDate = datePicker.date
        completion?(remindDate)
    }
}
