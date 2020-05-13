//
//  Definitions + Constants.swift
//  NV_ORG
//
//  Created by Netventure on 17/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation


let NGROK_ID : String                                   = "2a4a4de9"
let BASE_URL : String                                     = "http://134.209.157.18/api/v1/"//"http://\(NGROK_ID).ngrok.io/api/v1/"

//MARK:- Login

let LOGIN_URL : String                                  = "login"
let OTP_SUBMIT_URL : String                        = "otp_submit"
let OTP_RESEND_URL : String                        = "otp_resend"
let EMAIL_VERIFY_URL : String                      = "forgot_password"
let RESET_PASSWORD_URL: String                = "reset_password"

//MARK:- DASHBOARD-HOME

let CHANGE_PASSWORD_URL : String          = "change_password"
let SIGN_OUT_URL : String                            = "signout"
let DASHBOARD_URL : String                        = "dashboard"
let DASHBOARD_FEED_URL : String              = "dashboard_feeds"
//MARK:- PROFILE

let USERDETAILS_URL : String                        = "user_details"
//MARK:- NEWS
let NEWS_LIST_URL : String                           = "news"

//MARK:- DIRECTORY

let DIRECTORY_LIST_URL : String                  = "directory_list"
let DIRECTORY_FILTER_LIST : String              = "directory_filter_list"
let DIRECTORY_MEMBER_DETAIL : String     = "member_detail"
 
//MARK:- GALLERY

let GALLERY_LIST_URL : String                      = "gallery"
let GALLERY_DETAIL_URL : String                 = ""


//MARK:- JOB LIST

let JOB_LIST_URL : String                               = "job_list"
let JOB_DETAIL_URL : String                          = "job_details/"//job_details/id
let JOB_TYPES_URL : String                            = "job_types_list"

let CELEBRATION_LIST_URL : String              = "celebration_list"

let MEETINGS_LIST_URL : String                    = "meeting_details/"//meeting_details/f8934ba0-8148-11ea-b1ab-a1a7eec7b352

//MARK:- Notification

let NOTIFICATION_LIST_URL : String             = "notifications_list"
let ANNOUNCEMENT_LIST_URL : String        = "announcement_list"


let EVENT_DETAILS_URL : String                     = "event_details"
