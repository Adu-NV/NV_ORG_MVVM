//
//  ResetPasswordResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 20/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation

struct ResetPasswordResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : ResetPasswordResponseData?
}

struct ResetPasswordResponseData : Decodable {
    let user : ResetPasswordResponseUser?
}

struct ResetPasswordResponseUser : Decodable {
    let id : Int?
    let membership_id : String?
    let firstname : String?
    let lastname : String?
    let email : String?
    let email_verified_at : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?

}
