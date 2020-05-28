//
//  NewsListResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 14/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct NewsDateListResponseModel : Codable {
    let code : Int?
    let message : String?
    let data : NewsDateListResponseData?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(NewsDateListResponseData.self, forKey: .data)
    }

}

struct NewsDateListResponseData : Codable {
    let news_date_list : [News_date_list]?
    let  event_list : [Event_Date_List]?
    
    enum CodingKeys: String, CodingKey {
        case event_list = "event_list"
        case news_date_list = "news_date_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        news_date_list = try values.decodeIfPresent([News_date_list].self, forKey: .news_date_list)
        event_list = try values.decodeIfPresent([Event_Date_List].self, forKey: .event_list)
    }

}

struct News_date_list : Codable {
    let news_date : String?

    enum CodingKeys: String, CodingKey {

        case news_date = "news_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        news_date = try values.decodeIfPresent(String.self, forKey: .news_date)
    }

}

struct Event_Date_List : Codable {
    let event_date : String?

    enum CodingKeys: String, CodingKey {

        case event_date = "event_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        event_date = try values.decodeIfPresent(String.self, forKey: .event_date)
    }

}

