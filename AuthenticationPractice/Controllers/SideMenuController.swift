//
//  SideMenuViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 23/10/21.
//

import UIKit

class SideMenuController: UITableViewController {

    
    var menuList = ["HOME", "SETTINGS", "ACCOUNT", "LOGOUT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1.0)
        tableView.separatorColor = .yellow
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 80 + 20)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menuItem")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuItem", for: indexPath)
        
        cell.backgroundColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1.0)
        cell.textLabel?.text = menuList[indexPath.row]
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if menuList[indexPath.row] == "LOGOUT" {
            let isSignedOut = NetworkManager.shared.signout()
            
            if isSignedOut {
                navigateLoginScreen()
            }
        } else if menuList[indexPath.row] == "SETTINGS" {
    
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 15
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
