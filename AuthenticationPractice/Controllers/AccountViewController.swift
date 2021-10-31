//
//  AccountViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 29/10/21.
//

import UIKit

class AccountViewController: UIViewController {

    var delegate: MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        // Do any additional setup after loading the view.
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1.0)
        navigationItem.title = menuItemConstants.account
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageConstants.menu), style: .plain, target: self, action: #selector(handleMenu))
    }
    
    @objc func handleMenu() {
        delegate?.menuHandler()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
