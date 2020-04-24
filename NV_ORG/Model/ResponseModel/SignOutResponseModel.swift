//
//  SignOutResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 28/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation

struct SignOutResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : SignOutResponseData?
}

struct SignOutResponseData : Decodable {
    let message : String?
}
