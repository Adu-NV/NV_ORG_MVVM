//
//  DirectoryFilterViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 30/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

struct DirectoryFilterViewModel{
    var countryList : [dataList] = []
    var positionList : [dataList] = []
    var locationsList : [dataList] = []
    
    mutating func setModel(model : DirectoryFilterResponseModel){
        if let _data = model.data{
            if let _ = _data.country_list,_data.country_list!.count > 0{
                setCountries(country :_data.country_list!)
            }
            
            if let _ = _data.current_Location_list,_data.current_Location_list!.count > 0{
                setLocation(location :_data.current_Location_list!)
            }
            
            if let _ = _data.position_in_Society_list,_data.position_in_Society_list!.count > 0{
                setPositions(position: _data.position_in_Society_list!)
            }
        }  
    }
    
    mutating func setLocation(location : [Current_Location_list]){
        for i in 0 ..< location.count{
            locationsList.append(dataList(location: location[i]))
        }
    }
    mutating func setPositions(position : [Position_in_Society_list]){
        for i in 0 ..< position.count{
            positionList.append(dataList(position: position[i]))
        }
    }
    
    mutating func setCountries(country : [Country_list]){
                for i in 0 ..< country.count{
            countryList.append(dataList(country: country[i]))
        }
    }
}


extension DirectoryFilterViewModel : DirectoryFilterViewModelDelegateProtocol{
    func skipButtontapped(view: UIViewController) {
        if let navController = view.navigationController {
            navController.popViewController(animated: true)
        }else{
            view.dismiss(animated: false, completion: nil)
        }
    }
}


public struct dataList {
    var country_id : Int?
    var country_name : String?
    
    var current_id : Int?
    var current_name : String?
    
    
    var position_id : String?
    var position_name : String?
    
    init() {
        country_id = 0
        country_name = ""
        
        current_id = 0
        current_name = ""
        
        
        position_id = ""
        position_name = ""
    }
    
    init(country : Country_list) {
        country_id = country.country_id!
        country_name = country.country_name!
    }
    
    init(position : Position_in_Society_list) {
        position_id = position.position_in_Society_id!
        position_name = position.position_in_Society_name!
    }
    
    init(location : Current_Location_list) {
        current_id = location.current_Location_id!
        current_name = location.current_Location_name!
    }
}
