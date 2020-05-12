//
//  JobTypeResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 10/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct JobTypeResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : [JobTypeResponseData]?
}

struct JobTypeResponseData : Decodable {
    let id : String?
    let name : String?
}
