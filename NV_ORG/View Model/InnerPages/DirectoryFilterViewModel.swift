//
//  DirectoryFilterViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 30/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit
//DirectoryFilterDelegate
struct DirectoryFilterViewModel{
    var countryList : [dataList] = []
    var positionList : [dataList] = []
    var locationsList : [dataList] = []
   
    
    mutating func setModel(model : DirectoryFilterResponseModel){
        if let _data = model.data{
            if let _ = _data.Country_list,_data.Country_list!.count > 0{
                setCountries(country :_data.Country_list!)
            }
            
            if let _ = _data.Current_Location_list,_data.Current_Location_list!.count > 0{
                setLocation(location :_data.Current_Location_list!)
            }
            
            if let _ = _data.Position_in_Society_list,_data.Position_in_Society_list!.count > 0{
                setPositions(position: _data.Position_in_Society_list!)
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
//"search_string":"search_data", "position_in_society":"position 1","country":"India","location":"haripad"

extension DirectoryFilterViewModel : DirectoryFilterViewModelDelegateProtocol{
    func filterButtonTapped(view: UIViewController, location: String, country: String, position: String) {
        
             view.dismiss(animated: false, completion: nil)
        }
    
    func skipButtontapped(view: UIViewController) {
       view.dismiss(animated: false, completion: nil)
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
        country_id = country.Country_id!
        country_name = country.Country_name!
    }
    
    init(position : Position_in_Society_list) {
        position_id = position.Position_in_Society_id!
        position_name = position.Position_in_Society_name!
    }
    
    init(location : Current_Location_list) {
        current_id = location.Current_Location_id!
        current_name = location.Current_Location_name!
    }
}
