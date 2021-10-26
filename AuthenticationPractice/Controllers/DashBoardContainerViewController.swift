//
//  DashBoardContainerViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 24/10/21.
//

import UIKit
import GoogleSignIn

class DashBoardContainerViewController: UIViewController {
    
    var menuController: SideMenuController!
    var centerController: UIViewController!
    var isOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHome()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Check if User logged in using Google
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if user == nil && NetworkManager.shared.getUID() == nil {
                // Show the app's signed-out state.
                self.navigateLoginScreen()
            }
        }
    }
    
    func configureHome() {
        
        let home = storyboard!.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        
        home.delegate = self
        centerController = UINavigationController(rootViewController: home)
        
        self.view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
        
    }
    
    func configureMenu() {
        if menuController == nil {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            menuController = storyBoard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuController
            
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("Menu Configure")
        }
    }
    
    func showMenu(isOpen: Bool) {
        if isOpen {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.centerController.view.frame.origin.x = 0
            },completion: nil)
        }
    }
}

extension DashBoardContainerViewController: MenuDelegate {
    func menuHandler() {
        print("Menu clicked")
        
        if !isOpen {
            configureMenu()
        }
        isOpen = !isOpen
        showMenu(isOpen: isOpen)
    }
}
