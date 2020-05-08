//
//  DirectoryViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 03/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class DirectoryViewModel{
    var number_row = 0
     let mainStory =  UIStoryboard.init(name: "Main", bundle: nil)
    var directory : [DirectoryData] = []
    var numberofSections : Int {
         return  1
     }
    func numberOfRowsInSection(_ section : Int) -> Int{
        return number_row
     }
    
    func heightForRow(_ row : Int) -> CGFloat{
        return UITableView.automaticDimension
    }
}

extension DirectoryViewModel : DirectoryViewModelDelegateProtocol{
    func setUpModel(model: DirectoryListResponseModel) {
        number_row = (model.data?.count)!
        for i in 0 ..< number_row{
            var new_Directory = DirectoryData(model.data![i])
            directory.append(new_Directory)
        }
    }
    
    func moveToProfile(id :String ,viewController : UIViewController){
        let directoryProfile = mainStory.instantiateViewController(withIdentifier: "DirectoryProfileViewController") as! DirectoryProfileViewController
        directoryProfile.id = id
        if #available(iOS 13.0, *) {
            viewController.navigationController?.pushViewController(directoryProfile, animated: false)
        }else{
            viewController.present(directoryProfile, animated: false, completion: nil)
        }
    }
    
    
}

public struct DirectoryData{
    var name: String?
    var position:String?
    var number:String?
    var image:String?
    var id : String?
    
    init() {
        name = ""
        position = ""
        number = ""
        image = ""
        id = ""
    }
    
    init(_ directory : DirectoryListResponseData) {
        name = directory.member_firstname! + directory.member_lastname!
        position = directory.member_designation!
        number = directory.member_phone!
        image = directory.member_picture!
        id =  "\(directory.member_id!)"
        
    }
}
