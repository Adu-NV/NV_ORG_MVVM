//
//  ResetPasswordRequestModel.swift
//  NV_ORG
//
//  Created by Netventure on 20/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit
/*
 "email":"email","password":,"password_confirmation":,"token":123456
 */


struct ResetPasswordRequestModel{
    
    var email : String?
    var password : String?
    var token : String?
    var password_confirmation : String?
    
    var updateDic : Dictionary<String,String> = [:]
    
    init(_email : String, _pass : String , _token : String, _confirm : String){
        self.email = _email
        self.password = _pass
        self.token = _token
        self.password_confirmation = _confirm
        self.updateDic["email"] = self.email!
        self.updateDic["password"] = self.password!
        self.updateDic["token"] = self.token!
        self.updateDic["password_confirmation"] = self.password_confirmation!
    }
}
