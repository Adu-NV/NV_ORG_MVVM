//
//  ProfileUpdateResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 13/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct ProfileUploadResponseModel : Codable {
    let code : Int?
    let message : String?
    let data : ProfileUploadResponseData?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(ProfileUploadResponseData.self, forKey: .data)
    }

}
struct ProfileUploadResponseData : Codable {
    let user_cover_picture : String?
    let user_profile_picture : String?
    let user_first_name : String?
    let user_last_name : String?
    let user_designation : String?
    let user_mobile : String?
    let user_email : String?
    let user_member_id : String?
    let user_mobile_No : String?
    let user_date_of_joining : String?
    let user_position_in_the_Society : String?
    let user_education : String?
    let user_job_experience : String?
    let user_career_profile : String?
    let user_martial_status : String?
    let user_spouse_name : String?
    let user_current_location : String?
    let user_country : String?
    let user_place_in_spain : String?
    let user_buddy_tree : String?
    let user_date_planted : String?

    enum CodingKeys: String, CodingKey {

        case user_cover_picture = "user_cover_picture"
        case user_profile_picture = "user_profile_picture"
        case user_first_name = "user_first_name"
        case user_last_name = "user_last_name"
        case user_designation = "user_designation"
        case user_mobile = "user_mobile"
        case user_email = "user_email"
        case user_member_id = "user_member_id"
        case user_mobile_No = "User_mobile_No"
        case user_date_of_joining = "user_date_of_joining"
        case user_position_in_the_Society = "user_position_in_the_Society"
        case user_education = "user_education"
        case user_job_experience = "user_job_experience"
        case user_career_profile = "user_career_profile"
        case user_martial_status = "user_martial_status"
        case user_spouse_name = "user_spouse_name"
        case user_current_location = "user_current_location"
        case user_country = "user_country"
        case user_place_in_spain = "user_place_in_spain"
        case user_buddy_tree = "user_buddy_tree"
        case user_date_planted = "user_date_planted"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_cover_picture = try values.decodeIfPresent(String.self, forKey: .user_cover_picture)
        user_profile_picture = try values.decodeIfPresent(String.self, forKey: .user_profile_picture)
        user_first_name = try values.decodeIfPresent(String.self, forKey: .user_first_name)
        user_last_name = try values.decodeIfPresent(String.self, forKey: .user_last_name)
        user_designation = try values.decodeIfPresent(String.self, forKey: .user_designation)
        user_mobile = try values.decodeIfPresent(String.self, forKey: .user_mobile)
        user_email = try values.decodeIfPresent(String.self, forKey: .user_email)
        user_member_id = try values.decodeIfPresent(String.self, forKey: .user_member_id)
        user_mobile_No = try values.decodeIfPresent(String.self, forKey: .user_mobile_No)
        user_date_of_joining = try values.decodeIfPresent(String.self, forKey: .user_date_of_joining)
        user_position_in_the_Society = try values.decodeIfPresent(String.self, forKey: .user_position_in_the_Society)
        user_education = try values.decodeIfPresent(String.self, forKey: .user_education)
        user_job_experience = try values.decodeIfPresent(String.self, forKey: .user_job_experience)
        user_career_profile = try values.decodeIfPresent(String.self, forKey: .user_career_profile)
        user_martial_status = try values.decodeIfPresent(String.self, forKey: .user_martial_status)
        user_spouse_name = try values.decodeIfPresent(String.self, forKey: .user_spouse_name)
        user_current_location = try values.decodeIfPresent(String.self, forKey: .user_current_location)
        user_country = try values.decodeIfPresent(String.self, forKey: .user_country)
        user_place_in_spain = try values.decodeIfPresent(String.self, forKey: .user_place_in_spain)
        user_buddy_tree = try values.decodeIfPresent(String.self, forKey: .user_buddy_tree)
        user_date_planted = try values.decodeIfPresent(String.self, forKey: .user_date_planted)
    }

}
