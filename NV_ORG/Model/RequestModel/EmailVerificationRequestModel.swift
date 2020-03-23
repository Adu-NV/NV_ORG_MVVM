//
//  EmailVerificationRequestModel.swift
//  NV_ORG
//
//  Created by Netventure on 19/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct EmailVerificationRequestModel{
    var email : String?
    
    var updateDic : Dictionary<String,String> = [:]
  
    init(_email : String){
        self.email = _email
        self.updateDic["email"] = self.email!
    }
}
