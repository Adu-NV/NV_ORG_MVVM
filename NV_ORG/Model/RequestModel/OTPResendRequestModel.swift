//
//  OTPResendRequestModel.swift
//  NV_ORG
//
//  Created by Netventure on 19/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct OTPResendRequestModel{
    var user_id : String?
    var deviceType : String?
    
    var updateDic : Dictionary<String,String> = [:]
    /*
     user_id,deviceType
     */
    
    init(_deviceType: String ,_user_id : String){
        self.deviceType = _deviceType
        self.user_id = _user_id
        
        self.updateDic["user_id"] = self.user_id!
        self.updateDic["deviceType"] = self.deviceType!
    }
}
