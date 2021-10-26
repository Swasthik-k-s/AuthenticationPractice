//
//  HomeViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 19/10/21.
//

import UIKit
import GoogleSignIn
//import SideMenu

class HomeViewController: UIViewController {
    
    var delegate: MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "HOME"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(handleMenu))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addPressed))
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    @objc func addPressed() {
        let addView = AddItemViewController()
        addView.modalPresentationStyle = .fullScreen
        present(addView, animated: true, completion: nil)
    }
    
    @objc func handleMenu() {
//        print("Menu CLicked done")
        delegate?.menuHandler()
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        let isSignedOut = NetworkManager.shared.signout()
        
        if isSignedOut {
            navigateLoginScreen()
        }
    }
    
}


