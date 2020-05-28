//
//  MeetingAttendingResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 14/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct MeetingAttendingResponseModel : Codable {
    let code : Int?
    let data : MeetingAttendingResponseData?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case data = "data"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent(MeetingAttendingResponseData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
struct MeetingAttendingResponseData : Codable {
    let is_attending : Bool?

    enum CodingKeys: String, CodingKey {

        case is_attending = "is_attending"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        is_attending = try values.decodeIfPresent(Bool.self, forKey: .is_attending)
    }

}
