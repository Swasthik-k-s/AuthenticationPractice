//
//  Constants.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 21/10/21.
//

import Foundation
import UIKit

struct StoryBoardConstants {
//    static let dashBoardVCIdentifier = "DashboardVC"

    static let loginVCIdentifier = "LoginNavigationVC"
    static let dashboardVCIdentifier = "DashboardVC"
    static let homeVCIdentifier = "HomeVC"
    static let addNoteVCIdentifier = "AddVC"
    static let menuVCIdentifier = "SideMenuVC"
    static let archiveVCIdentifier = "ArchiveVC"
    static let reminderVCIdentifier = "ReminderVC"
    static let settingsVCIdentifier = "SettingsVC"
    static let accountVCIdentifier = "AccountVC"
    static let dateTimePickerVCIdentifier = "dateTimePickerVC"
}

struct APIConstants {
    static let clientID = "351764325788-01c3vvunt73n868o1k13mtqp5lfn83gt.apps.googleusercontent.com"
}

struct messageConstants {
    static let emailInvalid = "Email is Invalid. Please Enter a Valid Email ID"
    static let passwordInvalid = "Password is Invalid. Password must contain atleast 8 character with 1 number and 1 special character"
    static let emptyFields = "Please fill all the Fields"
}

struct imageConstants {
    static let gridView = "rectangle.grid.2x2.fill"
    static let lineView = "rectangle.grid.1x2.fill"
    static let home = "house.fill"
    static let archived = "folder.fill.badge.plus"
    static let reminder = "alarm.fill"
    static let settings = "gearshape.fill"
    static let account = "person.crop.square.fill"
    static let logout = "arrow.left.to.line"
    static let add = "plus.circle.fill"
    static let delete = "trash"
    static let x = "clear.fill"
    static let menu = "line.horizontal.3"
    static  let defaultProfile = UIImage(systemName: "person")!
    static let archive = UIImage(systemName: "folder.fill.badge.plus")
    static let unarchive = UIImage(systemName: "folder.fill.badge.minus")
    static let remind = UIImage(systemName: "alarm.fill")
}

struct colorConstants {
    static let black1 = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0)
    static let black2 = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1.0)
    
}

struct menuItemConstants {
    static let home = "Home"
    static let archive = "Archive"
    static let reminder = "Reminder"
    static let settings = "Settings"
    static let account = "Account"
    static let logout = "Logout"
    
    static let menuItemArray = ["Home", "Archive", "Reminder", "Settings", "Account", "Logout"]
    static let menuImageArray = [imageConstants.home,
                                 imageConstants.archived,
                                 imageConstants.reminder,
                                 imageConstants.settings,
                                 imageConstants.account,
                                 imageConstants.logout]
}

enum NoteError: Error {
    
}


