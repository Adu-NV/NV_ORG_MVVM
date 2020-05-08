//
//  JobDetailResponseModel.swift
//  NV_ORG
//
//  Created by Netventure on 07/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct JobDetailResponseModel : Decodable {
    let code : Int?
    let message : String?
    let data : JobDetailResponseData?
}

struct JobDetailResponseData : Decodable {
    let job_details : [Job_details_Model]?
    let related_jobs_list : [Related_jobs_list]?
}

struct Job_details_Model : Decodable {
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

struct Related_jobs_list : Decodable {
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
