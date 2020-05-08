//
//  GalleryListResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 06/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct GalleryListResponseModel : Decodable {
    let code : Int?
    let data : GalleryListResponseData?
    let message : String?
}
struct GalleryListResponseData : Decodable {
    let gallery_list : [Gallery_lists]?

}
struct Gallery_lists : Decodable {
let gallery_URL : String?
let gallery_id : String?
}
