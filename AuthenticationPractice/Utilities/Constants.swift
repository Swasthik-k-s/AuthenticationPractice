//
//  Constants.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 21/10/21.
//

import Foundation

struct StoryBoardConstants {
//    static let dashBoardVCIdentifier = "DashboardVC"

    static let loginVCIdentifier = "LoginNavigationVC"
    static let dashboardVCIdentifier = "DashboardVC"
    static let homeVCIdentifier = "HomeVC"
    static let menuVCIdentifier = "SideMenuVC"
    static let settingsVCIdentifier = "SettingsVC"
    static let accountVCIdentifier = "AccountVC"
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
    static let settings = "gearshape.fill"
    static let account = "person.crop.square.fill"
    static let logout = "arrow.left.to.line"
    static let add = "plus.circle.fill"
    static let delete = "trash"
    static let x = "clear.fill"
    static let menu = "line.horizontal.3"
}

struct colorConstants {
    
}

struct menuItemConstants {
    static let home = "HOME"
    static let settings = "SETTINGS"
    static let account = "ACCOUNT"
    static let logout = "LOGOUT"
    
    static let menuItemArray = ["HOME", "SETTINGS", "ACCOUNT", "LOGOUT"]
    static let menuImageArray = [imageConstants.home,
                                 imageConstants.settings,
                                 imageConstants.account,
                                 imageConstants.logout]
}



