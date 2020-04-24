//
//  DashBoardResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 28/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation

public struct DashBoardResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : DashBoardResponseData?
}


public struct DashBoardResponseData : Decodable {
    let user_mobile_number : String?
    let user_image_url : String?
    let is_chat : Bool?
    let chat_unread_count : Int?
    let is_news : Bool?
    let is_events : Bool?
    let is_meetings : Bool?
    let is_celebrating : Bool?
    let is_job_vacancy : Bool?
    let is_gallery : Bool?
    let is_advertisment : Bool?
}
