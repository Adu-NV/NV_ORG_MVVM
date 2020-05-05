//
//  DirectoryListResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 28/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
public struct DirectoryListResponseModel : Decodable {
    let code : Int?
    let data : [DirectoryListResponseData]?
    let message : String?
}

public struct DirectoryListResponseData : Decodable {
    let country_name : String?
    let current_Location_name : String?
    let position_in_Society_name : String?
    let member_designation : String?
    let member_firstname : String?
    let member_id : Int?
    let member_lastname : String?
    let member_phone : String?
    let member_picture : String?
    let membership_id : String?
}
