//
//  LoginRequestModel.swift
//  NV_ORG
//
//  Created by Netventure on 18/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct LoginRequestModel {
    var deviceType : String?
    var password : String?
    var username : String?
    
    var dictionary : Dictionary<String,String> = [:]
    
    init(_deviceType: String ,_password : String ,_username : String){
        self.deviceType = _deviceType
        self.username = _username
        self.password = _password
        
        self.dictionary["username"] = self.username!
        self.dictionary["password"] = self.password!
        self.dictionary["deviceType"] = self.deviceType!
    }
}
