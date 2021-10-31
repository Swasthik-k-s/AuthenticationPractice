//
//  SideMenuViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 23/10/21.
//

import UIKit

class SideMenuController: UITableViewController {
    
    var menuList = menuItemConstants.menuItemArray
    var menuImage = menuItemConstants.menuImageArray
    
    var delegate: MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1.0)
        tableView.separatorColor = .yellow
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 80 + 20)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menuItem")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuItem", for: indexPath) as! SideMenuCell
        
        cell.backgroundColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1.0)
        
        cell.menuLabel.text = menuList[indexPath.row]
        cell.menuLabel.textColor = .white
        
        cell.iconImage.image = UIImage(systemName: menuImage[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectMenu(menuItem: menuList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.menuHandler()
    }
}
