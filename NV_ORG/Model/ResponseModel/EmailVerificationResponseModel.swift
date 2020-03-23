//
//  EmailVerificationResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 19/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct EmailVerificationResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data :  EmailVerificationResponseData?

}


struct  EmailVerificationResponseData : Decodable {
    let token : Int?
    let message : String?
}
