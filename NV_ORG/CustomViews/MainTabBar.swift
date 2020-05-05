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
//        fatalError("init(coder:) has not been implemented")\
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.barStyle = .default
        self.tabBar.backgroundColor = BUTTON_LOGIN_COLOR
        self.tabBar.layer.cornerRadius   = 20.0
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        self.delegate = self
//        self.tabBar.selectedItem.h
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

extension MainTabBar : UITabBarControllerDelegate{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        debugPrint("\(item.title)")
        
    }
    
}
