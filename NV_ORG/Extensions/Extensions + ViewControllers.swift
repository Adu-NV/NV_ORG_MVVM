//
//  Extensions + ViewControllers.swift
//  NV_ORG
//
//  Created by Netventure on 17/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController{
    public static var storyBoard : UIStoryboard{
        return UIStoryboard.init(name: "Main", bundle: Bundle(for: self))
    }
    
    public static func instance(delegate: LoginViewDelegateProtocol) -> LoginViewController{
        let  vc = storyBoard.instantiateInitialViewController() as?  LoginViewController
        vc?.delegate = delegate
        return vc!
    }
    
    public var inNavigationController : UINavigationController{
        return UINavigationController.init(rootViewController: self)
    }
    
}
