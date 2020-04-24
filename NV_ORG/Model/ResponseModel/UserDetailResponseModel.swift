//
//  UserDetailResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 01/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
public struct UserDetailsResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : UserDetailResponseData?

}

public struct UserDetailResponseData : Decodable {
    let user_id : Int?
    let user_membership_id : String?
    let user_cover_picture : String?
    let user_profile_picture : String?
    let user_name : String?
    let user_firstname: String?
    let user_lastname:String?
    let user_designation : String?
    let user_mobile : String?
    let user_email : String?
    let user_position_society : String?
    let user_group : String?
    let user_date_of_joining : String?
    let user_address : String?
    let user_education : String?
    let user_job_experience : String?
    let user_career_profile : String?
    let user_martial_status : String?
    let user_spouse_name : String?
    let user_city : String?
    let user_state : String?
    let user_buddy_tree : String?
    let user_date_planted : String?

}
/*
 {
 "code": 200,
 "message": "Successful",
 "data": {
 "user_id": 9,
 "user_membership_id": "2000",
 "user_cover_picture": "http://242dd57c.ngrok.io/storage/upload/user/family_photo/86709b6c-93fd-4c29-8b73-24bbc86a15a7_080ec673-a8b1-407a-8f76-82d3c6b3633a_family.jpg",
 "user_profile_picture": "http://242dd57c.ngrok.io/storage/upload/user/photo/86709b6c-93fd-4c29-8b73-24bbc86a15a7_download.png",
 "user_name": "Antony Issac",
 "user_designation": "Web Developer",
 "user_mobile": "+918547387978",
 "user_email": "antony@netventure.in",
 "user_position_society": "Position 1",
 "user_group": "Team 1",
 "user_date_of_joining": "2020-02-13",
 "user_address": "Thekkepalackal house, kattoor P.O",
 "user_education": "Bachelor's degree",
 "user_job_experience": "4",
 "user_career_profile": "Web Developer",
 "user_martial_status": "Yes",
 "user_spouse_name": "Asha",
 "user_city": "Haripad",
 "user_state": "Kerala",
 "user_buddy_tree": "Oak",
 "user_date_planted": "2020-02-01" } }
 */
