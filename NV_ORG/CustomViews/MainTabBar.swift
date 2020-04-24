//
//  MainTabBar.swift
//  NV_ORG
//
//  Created by Netventure on 28/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class MainTabBar : UITabBarController{
    var viewcontroller : [UIViewController]?

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    func setUPViewController(){
        let mainstoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let dashBoard =  mainstoryBoard.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        let directory =  mainstoryBoard.instantiateViewController(withIdentifier: "DirectoryViewController") as! DirectoryViewController
        let notification =  mainstoryBoard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        let profile =  mainstoryBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        viewcontroller = [dashBoard,directory,notification,profile]
        self.viewControllers = viewcontroller
    }
    
}
