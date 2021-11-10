//
//  SettingsViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 27/10/21.
//

import UIKit

class SettingsViewController: UIViewController {

    var delegate: MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureScreen()
        // Do any additional setup after loading the view.
    }
    
    func configureNavigation() {
        
        navigationItem.title = menuItemConstants.settings
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageConstants.menu), style: .plain, target: self, action: #selector(handleMenu))
    }
    
    @objc func handleMenu() {
        delegate?.menuHandler()
    }

}
