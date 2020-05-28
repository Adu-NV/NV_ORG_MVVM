//
//  NewsDetailsResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 14/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct NewsDetailsResponseModel : Codable {
    let code : Int?
    let message : String?
    let data : NewsDetailsResponseData?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(NewsDetailsResponseData.self, forKey: .data)
    }

}
struct NewsDetailsResponseData : Codable {
    let current_news_details : [Current_news_details]?
    let previous_date : String?
    let next_date : String?

    enum CodingKeys: String, CodingKey {

        case current_news_details = "current_news_details"
        case previous_date = "previous_date"
        case next_date = "next_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current_news_details = try values.decodeIfPresent([Current_news_details].self, forKey: .current_news_details)
        previous_date = try values.decodeIfPresent(String.self, forKey: .previous_date)
        next_date = try values.decodeIfPresent(String.self, forKey: .next_date)
    }

}

struct Current_news_details : Codable {
    let news_id : String?
    let news_name : String?
    let news_author : String?
    let news_date : String?
    let news_url : String?
    let news_brief : String?

    enum CodingKeys: String, CodingKey {

        case news_id = "news_id"
        case news_name = "news_name"
        case news_author = "news_author"
        case news_date = "news_date"
        case news_url = "news_url"
        case news_brief = "news_brief"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        news_id = try values.decodeIfPresent(String.self, forKey: .news_id)
        news_name = try values.decodeIfPresent(String.self, forKey: .news_name)
        news_author = try values.decodeIfPresent(String.self, forKey: .news_author)
        news_date = try values.decodeIfPresent(String.self, forKey: .news_date)
        news_url = try values.decodeIfPresent(String.self, forKey: .news_url)
        news_brief = try values.decodeIfPresent(String.self, forKey: .news_brief)
    }

}
