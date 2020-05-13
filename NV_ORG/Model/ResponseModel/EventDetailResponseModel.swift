//
//  EventDetailResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 13/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct EventsDetailsResponeModel : Codable {
    let code : Int?
    let message : String?
    let data : EventsDetailsResponeData?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(EventsDetailsResponeData.self, forKey: .data)
    }

}
struct EventsDetailsResponeData : Codable {
    let current_event_details : Current_event_details?
    let upcoming_event_list : [Upcoming_event_list]?
    let previous_event_list : [Previous_event_list]?

    enum CodingKeys: String, CodingKey {

        case current_event_details = "current_event_details"
        case upcoming_event_list = "upcoming_event_list"
        case previous_event_list = "previous_event_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current_event_details = try values.decodeIfPresent(Current_event_details.self, forKey: .current_event_details)
        upcoming_event_list = try values.decodeIfPresent([Upcoming_event_list].self, forKey: .upcoming_event_list)
        previous_event_list = try values.decodeIfPresent([Previous_event_list].self, forKey: .previous_event_list)
    }

}
struct Current_event_details : Codable {
    let event_id : String?
    let event_date : String?
    let event_venue : String?
    let event_venue_country : String?
    let event_venue_state : String?
    let event_venue_city : String?
    let event_venue_address : String?
    let event_time : String?
    let event_name : String?
    let event_organizer_picture : String?
    let event_picture : String?
    let event_organizer_name : String?
    let event_organizer_address : String?
    let event_organizer_contact : String?
    let event_organizer_email : String?
    let event_entry_fee : String?
    let event_register_url : String?
    let event_references_url : String?
    let event_brief : String?

    enum CodingKeys: String, CodingKey {

        case event_id = "event_id"
        case event_date = "event_date"
        case event_venue = "event_venue"
        case event_venue_country = "event_venue_country"
        case event_venue_state = "event_venue_state"
        case event_venue_city = "event_venue_city"
        case event_venue_address = "event_venue_address"
        case event_time = "event_time"
        case event_name = "event_name"
        case event_organizer_picture = "event_organizer_picture"
        case event_picture = "event_picture"
        case event_organizer_name = "event_organizer_name"
        case event_organizer_address = "event_organizer_address"
        case event_organizer_contact = "event_organizer_contact"
        case event_organizer_email = "event_organizer_email"
        case event_entry_fee = "event_entry_fee"
        case event_register_url = "event_register_url"
        case event_references_url = "event_references_url"
        case event_brief = "event_brief"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        event_id = try values.decodeIfPresent(String.self, forKey: .event_id)
        event_date = try values.decodeIfPresent(String.self, forKey: .event_date)
        event_venue = try values.decodeIfPresent(String.self, forKey: .event_venue)
        event_venue_country = try values.decodeIfPresent(String.self, forKey: .event_venue_country)
        event_venue_state = try values.decodeIfPresent(String.self, forKey: .event_venue_state)
        event_venue_city = try values.decodeIfPresent(String.self, forKey: .event_venue_city)
        event_venue_address = try values.decodeIfPresent(String.self, forKey: .event_venue_address)
        event_time = try values.decodeIfPresent(String.self, forKey: .event_time)
        event_name = try values.decodeIfPresent(String.self, forKey: .event_name)
        event_organizer_picture = try values.decodeIfPresent(String.self, forKey: .event_organizer_picture)
        event_picture = try values.decodeIfPresent(String.self, forKey: .event_picture)
        event_organizer_name = try values.decodeIfPresent(String.self, forKey: .event_organizer_name)
        event_organizer_address = try values.decodeIfPresent(String.self, forKey: .event_organizer_address)
        event_organizer_contact = try values.decodeIfPresent(String.self, forKey: .event_organizer_contact)
        event_organizer_email = try values.decodeIfPresent(String.self, forKey: .event_organizer_email)
        event_entry_fee = try values.decodeIfPresent(String.self, forKey: .event_entry_fee)
        event_register_url = try values.decodeIfPresent(String.self, forKey: .event_register_url)
        event_references_url = try values.decodeIfPresent(String.self, forKey: .event_references_url)
        event_brief = try values.decodeIfPresent(String.self, forKey: .event_brief)
    }
}

struct Upcoming_event_list : Codable {
    let event_id : String?
    let event_date : String?
    let event_venue : String?
    let event_venue_country : String?
    let event_venue_state : String?
    let event_venue_city : String?
    let event_venue_address : String?
    let event_time : String?
    let event_name : String?
    let event_organizer_picture : String?
    let event_picture : String?
    let event_organizer_name : String?
    let event_organizer_address : String?
    let event_organizer_contact : String?
    let event_organizer_email : String?
    let event_entry_fee : String?
    let event_register_url : String?
    let event_references_url : String?
    let event_brief : String?

    enum CodingKeys: String, CodingKey {

        case event_id = "event_id"
        case event_date = "event_date"
        case event_venue = "event_venue"
        case event_venue_country = "event_venue_country"
        case event_venue_state = "event_venue_state"
        case event_venue_city = "event_venue_city"
        case event_venue_address = "event_venue_address"
        case event_time = "event_time"
        case event_name = "event_name"
        case event_organizer_picture = "event_organizer_picture"
        case event_picture = "event_picture"
        case event_organizer_name = "event_organizer_name"
        case event_organizer_address = "event_organizer_address"
        case event_organizer_contact = "event_organizer_contact"
        case event_organizer_email = "event_organizer_email"
        case event_entry_fee = "event_entry_fee"
        case event_register_url = "event_register_url"
        case event_references_url = "event_references_url"
        case event_brief = "event_brief"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        event_id = try values.decodeIfPresent(String.self, forKey: .event_id)
        event_date = try values.decodeIfPresent(String.self, forKey: .event_date)
        event_venue = try values.decodeIfPresent(String.self, forKey: .event_venue)
        event_venue_country = try values.decodeIfPresent(String.self, forKey: .event_venue_country)
        event_venue_state = try values.decodeIfPresent(String.self, forKey: .event_venue_state)
        event_venue_city = try values.decodeIfPresent(String.self, forKey: .event_venue_city)
        event_venue_address = try values.decodeIfPresent(String.self, forKey: .event_venue_address)
        event_time = try values.decodeIfPresent(String.self, forKey: .event_time)
        event_name = try values.decodeIfPresent(String.self, forKey: .event_name)
        event_organizer_picture = try values.decodeIfPresent(String.self, forKey: .event_organizer_picture)
        event_picture = try values.decodeIfPresent(String.self, forKey: .event_picture)
        event_organizer_name = try values.decodeIfPresent(String.self, forKey: .event_organizer_name)
        event_organizer_address = try values.decodeIfPresent(String.self, forKey: .event_organizer_address)
        event_organizer_contact = try values.decodeIfPresent(String.self, forKey: .event_organizer_contact)
        event_organizer_email = try values.decodeIfPresent(String.self, forKey: .event_organizer_email)
        event_entry_fee = try values.decodeIfPresent(String.self, forKey: .event_entry_fee)
        event_register_url = try values.decodeIfPresent(String.self, forKey: .event_register_url)
        event_references_url = try values.decodeIfPresent(String.self, forKey: .event_references_url)
        event_brief = try values.decodeIfPresent(String.self, forKey: .event_brief)
    }

}

struct Previous_event_list : Codable {
    let event_id : String?
    let event_date : String?
    let event_venue : String?
    let event_venue_country : String?
    let event_venue_state : String?
    let event_venue_city : String?
    let event_venue_address : String?
    let event_time : String?
    let event_name : String?
    let event_organizer_picture : String?
    let event_picture : String?
    let event_organizer_name : String?
    let event_organizer_address : String?
    let event_organizer_contact : String?
    let event_organizer_email : String?
    let event_entry_fee : String?
    let event_register_url : String?
    let event_references_url : String?
    let event_brief : String?

    enum CodingKeys: String, CodingKey {

        case event_id = "event_id"
        case event_date = "event_date"
        case event_venue = "event_venue"
        case event_venue_country = "event_venue_country"
        case event_venue_state = "event_venue_state"
        case event_venue_city = "event_venue_city"
        case event_venue_address = "event_venue_address"
        case event_time = "event_time"
        case event_name = "event_name"
        case event_organizer_picture = "event_organizer_picture"
        case event_picture = "event_picture"
        case event_organizer_name = "event_organizer_name"
        case event_organizer_address = "event_organizer_address"
        case event_organizer_contact = "event_organizer_contact"
        case event_organizer_email = "event_organizer_email"
        case event_entry_fee = "event_entry_fee"
        case event_register_url = "event_register_url"
        case event_references_url = "event_references_url"
        case event_brief = "event_brief"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        event_id = try values.decodeIfPresent(String.self, forKey: .event_id)
        event_date = try values.decodeIfPresent(String.self, forKey: .event_date)
        event_venue = try values.decodeIfPresent(String.self, forKey: .event_venue)
        event_venue_country = try values.decodeIfPresent(String.self, forKey: .event_venue_country)
        event_venue_state = try values.decodeIfPresent(String.self, forKey: .event_venue_state)
        event_venue_city = try values.decodeIfPresent(String.self, forKey: .event_venue_city)
        event_venue_address = try values.decodeIfPresent(String.self, forKey: .event_venue_address)
        event_time = try values.decodeIfPresent(String.self, forKey: .event_time)
        event_name = try values.decodeIfPresent(String.self, forKey: .event_name)
        event_organizer_picture = try values.decodeIfPresent(String.self, forKey: .event_organizer_picture)
        event_picture = try values.decodeIfPresent(String.self, forKey: .event_picture)
        event_organizer_name = try values.decodeIfPresent(String.self, forKey: .event_organizer_name)
        event_organizer_address = try values.decodeIfPresent(String.self, forKey: .event_organizer_address)
        event_organizer_contact = try values.decodeIfPresent(String.self, forKey: .event_organizer_contact)
        event_organizer_email = try values.decodeIfPresent(String.self, forKey: .event_organizer_email)
        event_entry_fee = try values.decodeIfPresent(String.self, forKey: .event_entry_fee)
        event_register_url = try values.decodeIfPresent(String.self, forKey: .event_register_url)
        event_references_url = try values.decodeIfPresent(String.self, forKey: .event_references_url)
        event_brief = try values.decodeIfPresent(String.self, forKey: .event_brief)
    }

}
