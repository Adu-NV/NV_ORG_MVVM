//
//  LoginResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 18/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
/*
 
 {
     "code": 200,
     "message": "Successful",
     "data": {
         "User_id": 9,
         "message": "Successful"
     }
 }  
 */

struct LoginResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : LoginResponseData?
}


struct LoginResponseData : Decodable{
    let User_id : Int?
    let message : String?
}
