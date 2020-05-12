//
//  MeetingsDetailsResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 11/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct MeetingsDetailsResponseModel : Codable {
    let code : Int?
    let message : String?
    let data : MeetingsDetailsResponseData?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(MeetingsDetailsResponseData.self, forKey: .data)
    }

}

struct MeetingsDetailsResponseData : Codable {
    let current_meeting : Current_meeting?
    let upcoming_meeting_list : [Upcoming_meeting_list]?
    let previous_meeting_list : [Previous_meeting_list]?

    enum CodingKeys: String, CodingKey {

        case current_meeting = "current_meeting"
        case upcoming_meeting_list = "upcoming_meeting_list"
        case previous_meeting_list = "previous_meeting_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current_meeting = try values.decodeIfPresent(Current_meeting.self, forKey: .current_meeting)
        upcoming_meeting_list = try values.decodeIfPresent([Upcoming_meeting_list].self, forKey: .upcoming_meeting_list)
        previous_meeting_list = try values.decodeIfPresent([Previous_meeting_list].self, forKey: .previous_meeting_list)
    }

}

struct Current_meeting : Codable {
    let meeting_id : String?
    let meeting_name : String?
    let meeting_date : String?
    let meeting_time : String?
    let meeting_theme : String?
    let meeting_at : String?
    let meeting_address : String?
    let meeting_country : String?
    let meeting_state : String?
    let meeting_city : String?
    let meeting_brief : String?
    let is_attending : String?

    enum CodingKeys: String, CodingKey {

        case meeting_id = "meeting_id"
        case meeting_name = "meeting_name"
        case meeting_date = "meeting_date"
        case meeting_time = "meeting_time"
        case meeting_theme = "meeting_theme"
        case meeting_at = "meeting_at"
        case meeting_address = "meeting_address"
        case meeting_country = "meeting_country"
        case meeting_state = "meeting_state"
        case meeting_city = "meeting_city"
        case meeting_brief = "meeting_brief"
        case is_attending = "is_attending"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meeting_id = try values.decodeIfPresent(String.self, forKey: .meeting_id)
        meeting_name = try values.decodeIfPresent(String.self, forKey: .meeting_name)
        meeting_date = try values.decodeIfPresent(String.self, forKey: .meeting_date)
        meeting_time = try values.decodeIfPresent(String.self, forKey: .meeting_time)
        meeting_theme = try values.decodeIfPresent(String.self, forKey: .meeting_theme)
        meeting_at = try values.decodeIfPresent(String.self, forKey: .meeting_at)
        meeting_address = try values.decodeIfPresent(String.self, forKey: .meeting_address)
        meeting_country = try values.decodeIfPresent(String.self, forKey: .meeting_country)
        meeting_state = try values.decodeIfPresent(String.self, forKey: .meeting_state)
        meeting_city = try values.decodeIfPresent(String.self, forKey: .meeting_city)
        meeting_brief = try values.decodeIfPresent(String.self, forKey: .meeting_brief)
        is_attending = try values.decodeIfPresent(String.self, forKey: .is_attending)
    }

}
struct Upcoming_meeting_list : Codable {
    let meeting_id : String?
    let meeting_name : String?
    let meeting_date : String?
    let meeting_time : String?
    let meeting_theme : String?
    let meeting_at : String?
    let meeting_address : String?
    let meeting_country : String?
    let meeting_state : String?
    let meeting_city : String?
    let meeting_brief : String?
    let is_attending : String?

    enum CodingKeys: String, CodingKey {

        case meeting_id = "meeting_id"
        case meeting_name = "meeting_name"
        case meeting_date = "meeting_date"
        case meeting_time = "meeting_time"
        case meeting_theme = "meeting_theme"
        case meeting_at = "meeting_at"
        case meeting_address = "meeting_address"
        case meeting_country = "meeting_country"
        case meeting_state = "meeting_state"
        case meeting_city = "meeting_city"
        case meeting_brief = "meeting_brief"
        case is_attending = "is_attending"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meeting_id = try values.decodeIfPresent(String.self, forKey: .meeting_id)
        meeting_name = try values.decodeIfPresent(String.self, forKey: .meeting_name)
        meeting_date = try values.decodeIfPresent(String.self, forKey: .meeting_date)
        meeting_time = try values.decodeIfPresent(String.self, forKey: .meeting_time)
        meeting_theme = try values.decodeIfPresent(String.self, forKey: .meeting_theme)
        meeting_at = try values.decodeIfPresent(String.self, forKey: .meeting_at)
        meeting_address = try values.decodeIfPresent(String.self, forKey: .meeting_address)
        meeting_country = try values.decodeIfPresent(String.self, forKey: .meeting_country)
        meeting_state = try values.decodeIfPresent(String.self, forKey: .meeting_state)
        meeting_city = try values.decodeIfPresent(String.self, forKey: .meeting_city)
        meeting_brief = try values.decodeIfPresent(String.self, forKey: .meeting_brief)
        is_attending = try values.decodeIfPresent(String.self, forKey: .is_attending)
    }

}

struct Previous_meeting_list : Codable {
    let meeting_id : String?
    let meeting_name : String?
    let meeting_date : String?
    let meeting_time : String?
    let meeting_theme : String?
    let meeting_at : String?
    let meeting_address : String?
    let meeting_country : String?
    let meeting_state : String?
    let meeting_city : String?
    let meeting_brief : String?
    let is_attending : String?

    enum CodingKeys: String, CodingKey {

        case meeting_id = "meeting_id"
        case meeting_name = "meeting_name"
        case meeting_date = "meeting_date"
        case meeting_time = "meeting_time"
        case meeting_theme = "meeting_theme"
        case meeting_at = "meeting_at"
        case meeting_address = "meeting_address"
        case meeting_country = "meeting_country"
        case meeting_state = "meeting_state"
        case meeting_city = "meeting_city"
        case meeting_brief = "meeting_brief"
        case is_attending = "is_attending"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meeting_id = try values.decodeIfPresent(String.self, forKey: .meeting_id)
        meeting_name = try values.decodeIfPresent(String.self, forKey: .meeting_name)
        meeting_date = try values.decodeIfPresent(String.self, forKey: .meeting_date)
        meeting_time = try values.decodeIfPresent(String.self, forKey: .meeting_time)
        meeting_theme = try values.decodeIfPresent(String.self, forKey: .meeting_theme)
        meeting_at = try values.decodeIfPresent(String.self, forKey: .meeting_at)
        meeting_address = try values.decodeIfPresent(String.self, forKey: .meeting_address)
        meeting_country = try values.decodeIfPresent(String.self, forKey: .meeting_country)
        meeting_state = try values.decodeIfPresent(String.self, forKey: .meeting_state)
        meeting_city = try values.decodeIfPresent(String.self, forKey: .meeting_city)
        meeting_brief = try values.decodeIfPresent(String.self, forKey: .meeting_brief)
        is_attending = try values.decodeIfPresent(String.self, forKey: .is_attending)
    }

}
