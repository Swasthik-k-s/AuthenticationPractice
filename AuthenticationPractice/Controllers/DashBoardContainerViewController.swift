//
//  DashBoardContainerViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 24/10/21.
//

import UIKit
import GoogleSignIn

class DashBoardContainerViewController: UIViewController {
    
    //    static let shared = DashBoardContainerViewController()
    
    var menuController: SideMenuController!
    var centerController: UIViewController!
    var archiveController: UIViewController!
    var settingsController: UIViewController!
    var accountController: UIViewController!
    var homeController: UIViewController!
    var archive: ArchiveViewController!
    var home: HomeViewController!
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//    var settingsController = SettingsViewController()
//    var accountController = AccountViewController()
//    var homeController = HomeViewController()
    
    var isOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureHome()
        addChildControllers()
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
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
    
    func addChildControllers() {
        archive = storyBoard.instantiateViewController(withIdentifier: StoryBoardConstants.archiveVCIdentifier) as! ArchiveViewController
        
        let settings = storyBoard.instantiateViewController(withIdentifier: StoryBoardConstants.settingsVCIdentifier) as! SettingsViewController
        
        let account = storyBoard.instantiateViewController(withIdentifier: StoryBoardConstants.accountVCIdentifier) as! AccountViewController
        
        archive.delegate = self
        settings.delegate = self
        account.delegate = self
        
        archiveController = UINavigationController(rootViewController: archive)
        settingsController = UINavigationController(rootViewController: settings)
        accountController = UINavigationController(rootViewController: account)
        
        addChild(archiveController)
        addChild(settingsController)
        addChild(accountController)
        
        view.addSubview(archiveController.view)
        view.addSubview(settingsController.view)
        view.addSubview(accountController.view)
        
//        settingsController.view.frame = view.bounds
//        accountController.view.frame = view.bounds
        
        archiveController.didMove(toParent: self)
        settingsController.didMove(toParent: self)
        accountController.didMove(toParent: self)
        
        archiveController.view.isHidden = true
        settingsController.view.isHidden = true
        accountController.view.isHidden = true
    }
    
    func configureHome() {
        
        home = storyboard!.instantiateViewController(withIdentifier: StoryBoardConstants.homeVCIdentifier) as! HomeViewController
        
        home.delegate = self
        homeController = UINavigationController(rootViewController: home)
        centerController = homeController
        
        self.view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
        
    }
    
    func configureMenu() {
        if menuController == nil {
            
            menuController = storyboard!.instantiateViewController(withIdentifier: StoryBoardConstants.menuVCIdentifier) as? SideMenuController
            
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
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
        
        if !isOpen {
            configureMenu()
        }
        
        isOpen = !isOpen
        showMenu(isOpen: isOpen)
    }
    
    func didSelectMenu(menuItem: String) {
        switch menuItem {
        case menuItemConstants.home:
            home.getData()
            centerController = homeController
            archiveController.view.isHidden = true
            settingsController.view.isHidden = true
            accountController.view.isHidden = true
            break
        case menuItemConstants.archive:
//            archive.loadView()
            archive.getData()
            centerController = archiveController
            archiveController.view.isHidden = false
            settingsController.view.isHidden = true
            accountController.view.isHidden = true
            break
        case menuItemConstants.settings:
            centerController = settingsController
            archiveController.view.isHidden = true
            settingsController.view.isHidden = false
            accountController.view.isHidden = true
            break
        case menuItemConstants.account:
            centerController = accountController
            archiveController.view.isHidden = true
            settingsController.view.isHidden = true
            accountController.view.isHidden = false
            break
        case menuItemConstants.logout:
            let isSignedOut = NetworkManager.shared.signout()
            
            if isSignedOut {
                navigateLoginScreen()
            }
                break
            default:
                return
            }
        }
    }
