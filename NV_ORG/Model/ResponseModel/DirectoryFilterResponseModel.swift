//
//  DirectoryFilterResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 30/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
public struct DirectoryFilterResponseModel : Decodable {
    let code : Int?
    let data : DirectoryFilterResponseData?
    let  message : String?
}

public struct DirectoryFilterResponseData : Decodable {
    let country_list : [Country_list]?
    let current_Location_list : [Current_Location_list]?
    let position_in_Society_list : [Position_in_Society_list]?
}

public struct Country_list : Decodable {
    let country_id : Int?
    let country_name : String?
}

public struct Current_Location_list : Decodable {
    let current_Location_id : Int?
    let current_Location_name : String?
}

public struct Position_in_Society_list : Decodable {
    let position_in_Society_id : String?
    let position_in_Society_name : String?
}
