//
//  CelebrationListResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 08/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct CelebrationListResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : CelebrationListResponseData?
}

struct CelebrationListResponseData : Decodable {
    let birthday_today_list : [Birthday_today_list]?
    let upcoming_birthday_today_list : [Upcoming_birthday_today_list]?
    let anniversary_today_list : [Anniversary_today_list]?
}

struct Birthday_today_list : Decodable {
    let user_celebration_id : Int?
    let user_celebration_profile_picture : String?
    let user_celebration_name : String?
    let user_celebration_age : Int?
    let user_celebration_email : String?
    let user_celebration_mobile_number : String?
}

struct Anniversary_today_list : Decodable {
    let user_celebration_id : Int?
    let user_celebration_profile_picture : String?
    let user_celebration_name : String?
    let user_celebration_age : Int?
    let user_celebration_email : String?
    let user_celebration_mobile_number : String?
}


struct Upcoming_birthday_today_list : Decodable {
    let user_celebration_id : Int?
    let user_celebration_profile_picture : String?
    let user_celebration_name : String?
    let user_celebration_age : Int?
    let user_celebration_email : String?
    let user_celebration_mobile_number : String?
}
