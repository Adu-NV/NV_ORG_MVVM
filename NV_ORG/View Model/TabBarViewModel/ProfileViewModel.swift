//
//  ProfileViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 02/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel{
    var profile : Profile?
    public var delegate : ProfileViewControllerDelegateProtocol?
    let main = UIStoryboard.init(name: "Main", bundle: nil)
}

extension ProfileViewModel :ProfileViewModelDelegateProtocol{

    
    func edittapped(view: UIViewController) {
        
        let edit = main.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        if #available(iOS 13.0, *) {
            view.navigationController?.pushViewController(edit, animated: false)
        }else{
            view.present(edit, animated: false, completion: nil)
        }
    }
    
    var numberofSections : Int {
         return  1
     }
    func numberOfRowsInSection(_ section : Int) -> Int{
        return 2
     }
    
    func heightForRow(_ row : Int) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func setProfileModel(model: UserDetailsResponseModel) {
        if model != nil {
            
        }
        profile = Profile(model: model.data!)
    }
    
    func getProfile()->Profile{
        return profile!
    }
    
    
}

struct Profile{
    var coverImage : String?
    var profileImage : String?
    var first_name : String?
    var last_name : String?
    var name:String?
    var occupation:String?
    var memberID:String?
    var mobileNo:String?
    var email:String?
    var position:String?
    var belong:String?
    var dateOfJoin:String?
    
    var address:String?
    var education:String?
    var job:String?
    var career:String?
    var maritial:String?
    var spouse:String?
    var currentLocation:String?
    var country:String?
    var placeInKerala:String?
    var buddyTree:String?
    var datePlanned:String?
    
    init(model : UserDetailResponseData) {
        coverImage = model.user_cover_picture!
        profileImage = model.user_profile_picture!
        
        first_name = model.user_firstname != nil ? model.user_firstname! : ""
        last_name = model.user_lastname != nil ? model.user_lastname! : ""
        name = model.user_name != nil ?  model.user_name! : first_name! + " " + last_name!
        occupation = model.user_designation!
        memberID = "\((model.user_id)!)"
        mobileNo = model.user_mobile!
        email = model.user_email!
        position = model.user_position_society!
        belong = model.user_group!
        dateOfJoin = model.user_date_of_joining!
        
        address = model.user_address!
        education = model.user_education!
        job = model.user_job_experience
        career = model.user_career_profile!
        maritial = model.user_martial_status!
        spouse = model.user_spouse_name!
        currentLocation = model.user_city!
        country = model.user_state!
        placeInKerala = model.user_state!
        buddyTree = model.user_buddy_tree!
        datePlanned = model.user_date_planted!
    }
}
