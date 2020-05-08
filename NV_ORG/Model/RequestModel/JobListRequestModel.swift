//
//  JobListRequestModel.swift
//  NV_ORG
//
//  Created by Netventure on 07/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
//search_word=web developer,job_type=freelance,state=Kerala
struct JobListRequestModel{
    var state : String?
    var search_word : String?
    var job_type : String?
    
    var updateDic : Dictionary<String,String> = [:]
    
    init() {
        self.state = ""
        self.search_word = ""
        self.job_type = ""
        
        self.updateDic["state"] = self.state!
        self.updateDic["search_word"] = self.search_word!
        self.updateDic["job_type"] = self.job_type!
    }
    
    init(_state: String ,_search_word : String ,_job_type: String){
        self.state = _state
        self.search_word = _search_word
        self.job_type = _job_type
        
        self.updateDic["state"] = self.state!
        self.updateDic["search_word"] = self.search_word!
        self.updateDic["job_type"] = self.job_type!
    }
}
