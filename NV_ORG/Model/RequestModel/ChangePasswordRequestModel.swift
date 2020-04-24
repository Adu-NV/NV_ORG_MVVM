//
//  ChangePasswordRequestModel.swift
//  NV_ORG
//
//  Created by Netventure on 27/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
/*
  current_password,new_password,new_confirm_password
 */


struct ChangePasswordRequestModel{
    var current_password : String?
    var new_password : String?
    var new_confirm_password : String?
    
     var updateDic : Dictionary<String,String> = [:]
    
        init(_current: String ,_new : String ,_confirm: String){
        self.current_password = _current
        self.new_password = _new
        self.new_confirm_password = _confirm
        
        self.updateDic["current_password"] = self.current_password!
        self.updateDic["new_password"] = self.new_password!
        self.updateDic["new_password_confirmation"] = self.new_confirm_password!
    }
}
