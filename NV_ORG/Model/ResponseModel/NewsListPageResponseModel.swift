//
//  NewsListPageResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 11/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
public struct NewsListpageResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : NewsListpageResponseData?
}

public struct NewsListpageResponseData :Decodable {
    let news_list : [News_list_Page]?
}

public struct News_list_Page : Decodable {
   let news_id : String?
    let news_name : String?
    let news_author_name : String?
    let news_date : String?
    let news_picture : String?
    let news_brief : String?
}
