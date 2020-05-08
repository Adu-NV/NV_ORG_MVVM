//
//  DirectoryProfileRequestModel.swift
//  NV_ORG
//
//  Created by Netventure on 08/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct DirectoryProfileRequestModel{
    var member_id : String?
    
    var updateDic : Dictionary<String,String> = [:]
    
    init(_id: String){
        self.member_id = _id
        self.updateDic["member_id"] = self.member_id!
    }
    init() {
        self.member_id = ""
        self.updateDic["member_id"] = self.member_id!
    }
}
