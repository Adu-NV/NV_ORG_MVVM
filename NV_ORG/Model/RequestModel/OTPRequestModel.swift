//
//  OTPRequestModel.swift
//  NV_ORG
//
//  Created by Netventure on 19/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation

struct OTPRequestModel{
    var user_id : String?
    var otp : String?
    var deviceType : String?
    var updateDic : Dictionary<String,String> = [:]
    
    init(_deviceType: String ,_otp : String ,_user_id : String){
        self.deviceType = _deviceType
        self.user_id = _user_id
        self.otp = _otp
        
        self.updateDic["user_id"] = self.user_id!
        self.updateDic["otp"] = self.otp!
        self.updateDic["deviceType"] = self.deviceType!
    }
    
}
