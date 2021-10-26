//
//  SideMenuViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 23/10/21.
//

import UIKit

class SideMenuController: UITableViewController {

    var menuList = ["Home", "Settings", "Account", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.backgroundColor = UIColor(red: 50/255.0, green: 50/255.0, blue: 50/255.0, alpha: 1.0)
        tableView.separatorColor = .black
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
        cell.textLabel?.text = menuList[indexPath.row]
        cell.textLabel?.textColor = .black
//        cell.backgroundColor = UIColor(red: 42/255.0, green: 42/255.0, blue: 42/255.0, alpha: 1.0)
        
        return cell
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
