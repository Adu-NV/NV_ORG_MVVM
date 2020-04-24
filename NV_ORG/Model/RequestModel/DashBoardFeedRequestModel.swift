//
//  DashBoardFeedRequestModel.swift
//  NV_ORG
//
//  Created by Netventure on 08/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
struct DashBoardFeedRequestModel{

    var is_chat : Bool?
    var is_news : Bool?
    var is_events : Bool?
    var is_meetings : Bool?
    var is_celebrating : Bool?
    var is_job_vacancy : Bool?
    var is_gallery : Bool?
    var is_advertisment : Bool?
    
     var updateDic : Dictionary<String,String> = [:]
    
    init(dashBoard : DashBoardResponseData?){
        self.is_chat = dashBoard?.is_chat!
        self.is_news = dashBoard?.is_news!
        self.is_events = dashBoard?.is_events!
        self.is_meetings = dashBoard?.is_meetings!
        self.is_celebrating = dashBoard?.is_celebrating!
        self.is_job_vacancy = dashBoard?.is_job_vacancy!
        self.is_gallery = dashBoard?.is_gallery!
        self.is_advertisment = dashBoard?.is_advertisment!

        
        self.updateDic["is_chat"] = "\(self.is_chat!)"
        self.updateDic["is_news"] = "\(self.is_news!)"
        self.updateDic["is_events"] = "\(self.is_events!)"
        self.updateDic["is_meetings"] = "\(self.is_meetings!)"
        self.updateDic["is_celebrating"] = "\(self.is_celebrating!)"
        self.updateDic["is_job_vacancy"] = "\(self.is_job_vacancy!)"
        self.updateDic["is_gallery"] = "\(self.is_gallery!)"
        self.updateDic["is_advertisment"] = "\(self.is_advertisment!)"

    }
}
/*
 " "is_chat": true,
                "chat_unread_count": 20,
                "is_news":true,
                "is_events":true,
                "is_meetings": true,
                "is_celebrating": true,
                "is_job_vacancy": true,
                "is_gallery": true,
                "is_advertisment": true": true,
                "chat_unread_count": 20,
                "is_news":true,
                "is_events":true,
                "is_meetings": true,
                "is_celebrating": true,
                "is_job_vacancy": true,
                "is_gallery": true,
                "is_advertisment": true
 */
