//
//  OTPResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 19/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct OTPResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : OTPResponseData?
}

struct OTPResponseData : Decodable {
    let User_id : Int?
    let token : String?
    let token_type : String?
    let expires_in : Int?
    let token_created_at : Int?
    let message : String?
}
