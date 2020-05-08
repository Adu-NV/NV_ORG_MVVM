//
//  NotificationListResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 07/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct NotificationListResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : NotificationListResponseData?
}

struct NotificationListResponseData : Decodable {
    let notifications_list : [Notifications_List]?
     let announcement_list : [Announcement_List]?
}
struct Notifications_List : Decodable {
    let notification_id : Int?
    let notification_brief : String?
}

struct Announcement_List : Decodable {
    let announcement_id : Int?
    let announcement_brief : String?
}
