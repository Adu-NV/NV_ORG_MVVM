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
    let job_details : [Job_details]?
}

struct Job_details : Decodable {
    let job_vacancy_id : String?
    let job_company_name : String?
    let job_vacancy_name : String?
    let job_vacancy_occasion : String?
    let job_salary_offered : String?
}
