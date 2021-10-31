//
//  SideMenuCell.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 29/10/21.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
