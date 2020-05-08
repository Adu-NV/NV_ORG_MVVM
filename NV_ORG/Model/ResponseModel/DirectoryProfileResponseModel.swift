//
//  DirectoryProfileResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 08/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct DirectoryProfileResponseModel : Codable {
    let code : Int?
    let message : String?
    let data : DirectoryProfileResponseData?

}
struct DirectoryProfileResponseData : Codable {
    let member_id : Int?
    let membership_id : String?
    let member_picture : String?
    let member_cover_picture : String?
    let member_firstname : String?
    let member_lastname : String?
    let member_designation : String?
    let member_phone : String?
    let member_email : String?
    let member_position_society : String?
    let member_group : String?
    let member_date_of_joining : String?
    let member_address : String?
    let member_education : String?
    let member_job_experience : String?
    let member_career_profile : String?
    let member_martial_status : String?
    let member_spouse_name : String?
    let member_city : String?
    let member_state : String?
    let member_buddy_tree : String?
    let member_date_planted : String?
}
