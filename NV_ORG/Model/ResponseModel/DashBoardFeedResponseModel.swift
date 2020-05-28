//
//  DashBoardFeedResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 08/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
public struct DashBoardFeedResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : DashBoardFeedResponseData?
}

struct DashBoardFeedResponseData : Decodable {
    let event_list : [Event_list]?
    let news_list : [News_list]?
    let meetings_list : [Meetings_list]?
    let celebration_list : [Celebration_list]?
    let job_vacancy_list : [Job_vacancy_list]?
    let gallery_list : [Gallery_list]?
    let advertisement_list : [Advertisement_list]?
}

struct Event_list : Decodable {
    let event_id : String?
    let event_name : String?
    let event_date : String?
    let event_url : String?
    let event_brief : String?
}

struct News_list : Decodable {
    let news_id : String?
    let news_name : String?
    let news_date : String?
    let news_url : String?
    let news_brief : String?
    
}

struct Meetings_list : Decodable {
    let meeting_id : String?
    let meeting_name : String?
    let meeting_date : String?
    let meeting_at : String?
    let meeting_address : String?
    let meeting_city : String?
}

struct Celebration_list : Decodable {
    let celebration_id : Int?
    let celebration_name : String?
    let celebration_occasion : String?
    let celebration_profile_picture : String?
}
struct Job_vacancy_list : Decodable {
    let job_vacancy_id : String?
    let job_vacancy_name : String?
    let job_vacancy_occasion : String?
}
struct Advertisement_list : Decodable {
    let advertisement_id : String?
    let advertisement_image_url : String?
    let advertisement_URL : String?
}

struct Gallery_list : Decodable {
    let gallery_id : String?
    let gallery_URL : String?
}
