//
//  OTPResendResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 19/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation

struct OTPResendRespondseModel : Decodable {
    let code : Int?
    let data : OTPResendRespondseData?
}
struct OTPResendRespondseData : Decodable {
    let user_id : Int?
    let message : String?
}
