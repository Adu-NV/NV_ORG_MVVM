//
//  JobsListPageResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 11/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct JobsPageListResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : JobsPageListResponseData?
}

struct JobsPageListResponseData : Decodable {
    let job_vacancy_list : [Job_details]?
}

struct Job_details : Decodable {
    let job_vacancy_id : String?
    let job_vacancy_company_logo : String?
    let job_vacancy_company_name : String?
    let job_vacancy_name : String?
    let job_vacancy_country : String?
    let job_vacancy_state : String?
    let job_vacancy_location : String?
    let job_vacancy_package : String?
    let job_vacancy_type : String?
    let job_posted_date : String?
}
