//
//  ProfileUpdateReqquestModel.swift
//  NV_ORG
//
//  Created by Netventure on 13/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
/*
 "user_cover_picture": (nullable) image_byte ,
 "user_profile_picture": (nullable) image_byte ,
 "user_first_name":(nullable)"Antony",
 "user_last_name":(nullable)"Isac",
 "user_designation":(nullable)"Chiet Technology Officer",
 "user_mobile": (nullable)"9656614696",
 "user_email":(nullable) "jkpo@test.com",*/


struct ProfileUpdateRequestModel{
    
    var user_cover_picture : Data?
    var user_profile_picture : Data?
    var user_first_name : String?
    var user_last_name : String?
    var user_designation : String?
    var user_mobile : String?
    var user_email : String?
    var updateDic : Dictionary<String,Any> = [:]
    
    init(coverImage : Data?, profileImage : Data?, firstName :String?, lastName: String?,designation: String?, mobile: String?,email: String? ){
        self.user_cover_picture = coverImage
        self.user_profile_picture = profileImage
        self.user_first_name = firstName
        self.user_last_name = lastName
        self.user_designation = designation
        self.user_mobile = mobile
        self.user_email = email
        
        
        self.updateDic["user_cover_picture"] = self.user_cover_picture!
        self.updateDic["user_profile_picture"] = self.user_profile_picture!
        self.updateDic["user_first_name"] = "\(self.user_first_name!)"
        self.updateDic["user_last_name"] = "\(self.user_last_name!)"
        self.updateDic["user_designation"] = "\(self.user_designation!)"
        self.updateDic["user_mobile"] = "\(self.user_mobile!)"
        self.updateDic["user_email"] = "\(self.user_email!)"
    }
}
