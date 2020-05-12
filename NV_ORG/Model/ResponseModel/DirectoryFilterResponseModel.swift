//
//  DirectoryFilterResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 30/04/20.
//  Copyright © 2020 netventure. All rights reserved.
/*{
"code": 200,
"message": "Successful",
"data": {
"Position_in_Society_list": [
{
"Position_in_Society_id": "3d9734e0-5a17-11ea-a382-7d13eefa34b3",
"Position_in_Society_name": "Position 1"
}
],
"Country_list": [
{
"Country_id": 101,
"Country_name": "India"
}
],
"Current_Location_list": [
{
"Current_Location_id": 1843,
"Current_Location_name": "Adimaly"
},
{
"Current_Location_id": 1844,
"Current_Location_name": "Adoor"
},
{
"Current_Location_id": 1847,
"Current_Location_name": "Alangad"
},
{
"Current_Location_id": 1848,
"Current_Location_name": "Alappuzha"
},
{
"Current_Location_id": 1854,
"Current_Location_name": "Attingal"
},
{
"Current_Location_id": 1897,
"Current_Location_name": "Haripad"
},
{
"Current_Location_id": 1921,
"Current_Location_name": "Kannur"
},
{
"Current_Location_id": 1923,
"Current_Location_name": "Karunagappally"
}
]
}
}

*/

import Foundation
public struct DirectoryFilterResponseModel : Decodable {
    let code : Int?
    let data : DirectoryFilterResponseData?
    let  message : String?
}

public struct DirectoryFilterResponseData : Decodable {
    let Country_list : [Country_list]?
    let Current_Location_list : [Current_Location_list]?
    let Position_in_Society_list : [Position_in_Society_list]?
}

public struct Country_list : Decodable {
    let Country_id : Int?
    let Country_name : String?
}

public struct Current_Location_list : Decodable {
    let Current_Location_id : Int?
    let Current_Location_name : String?
}

public struct Position_in_Society_list : Decodable {
    let Position_in_Society_id : String?
    let Position_in_Society_name : String?
}
