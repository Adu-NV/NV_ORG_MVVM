//
//  WebService + POST.swift
//  NV_ORG
//
//  Created by Netventure on 18/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

extension Webservice{

    func Login(body : Dictionary<String,String>, completionBlock : @escaping(LoginResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + LOGIN_URL)
        do {
            var request  = URLRequest(url: url!)
            request.httpMethod = "POST"
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let login = try? jsonDecoder.decode(LoginResponseModel.self,from: data)
                        if login?.data != nil{
                            if  (login?.code)! != 401{
                                debugPrint("model \(login)")
                                UserDefaults.standard.set((login?.data?.User_id)!, forKey: "userID")
                                completionBlock(login, nil)
                            }else{
                                completionBlock(nil, (login?.message)!)
                            }
                            //!.articles)
                        }else{
                            completionBlock(nil,"internet error")
                        }
                    }
                }catch {
                }
            }
            task.resume()
        }catch{
        }
    }
    
    //MARK: OTP Submit
    
    func OTPSubmit(body : Dictionary<String,String>, completionBlock : @escaping(OTPResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + OTP_SUBMIT_URL)
        do {
            var request  = URLRequest(url: url!)
            request.httpMethod = "POST"
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let otp = try? jsonDecoder.decode(OTPResponseModel.self,from: data)
                        if otp?.data != nil{
                            if  (otp?.code)! == 200{
                                UserDefaults.standard.set((otp?.data?.token)!, forKey: "token")
                                UserDefaults.standard.set((otp?.data?.token_type)!, forKey: "token_type")
                                completionBlock(otp, nil)
                            }else{
                                completionBlock(nil, (otp?.message)!)
                            }
                            //!.articles)
                        }else{
                            completionBlock(nil,"internet error")
                        }
                    }
                }catch{
                }
            }
            task.resume()
        }catch{
        }
    }
    
     //MARK: OTP Re-Submit
        func OTPReSubmit(body : Dictionary<String,String>, completionBlock : @escaping(OTPResendRespondseModel?,String?) -> ()){
            let url = URL(string : BASE_URL + OTP_RESEND_URL)
            do {
                let request  = getRequest(url: url!, method: .post, auth: false, accept: .json, Content_Type: .json, body: body)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    let jsonDecoder = JSONDecoder()
                    do{
                        if let error = error{
                            debugPrint(error.localizedDescription)
                            completionBlock(nil, "internet error")
                        }else if let data = data{
                            let otp = try? jsonDecoder.decode(OTPResendRespondseModel.self,from: data)
                            if otp?.data != nil{
                                if  (otp?.code)! == 200{
                                    completionBlock(otp, nil)
                                }else{
                                    completionBlock(nil, "Not send")
                                }
                            }else{
                                completionBlock(nil,"internet error")
                            }
                        }
                    }catch{
                    }
                }
                task.resume()
            }catch{
            }
        }
    
    //MARK: EmailVerification
       func EmailVerification(body : Dictionary<String,String>, completionBlock : @escaping(EmailVerificationResponseModel?,String?) -> ()){
           let url = URL(string : BASE_URL + EMAIL_VERIFY_URL)
           do {
               let request  = getRequest(url: url!, method: .post, auth: false, accept: .json, Content_Type: .json, body: body)
               let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                   let jsonDecoder = JSONDecoder()
                   do{
                       if let error = error{
                           debugPrint(error.localizedDescription)
                           completionBlock(nil, "internet error")
                       }else if let data = data{
                           let email = try? jsonDecoder.decode(EmailVerificationResponseModel.self,from: data)
                           if email?.data != nil{
                               if  (email?.code)! == 200{
                                   completionBlock(email, nil)
                               }else{
                                completionBlock(nil, email?.message!)
                               }
                           }else{
                               completionBlock(nil,"internet error")
                           }
                       }
                   }catch{
                   }
               }
               task.resume()
           }catch{
           }
       }
    
    //MARK: ResetVerification
        func ResetPassword(body : Dictionary<String,String>, completionBlock : @escaping(ResetPasswordResponseModel?,String?) -> ()){
            let url = URL(string : BASE_URL + RESET_PASSWORD_URL)
            do {
                let request  = getRequest(url: url!, method: .post, auth: false, accept: .json, Content_Type: .json, body: body)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    let jsonDecoder = JSONDecoder()
                    do{
                        if let error = error{
                            debugPrint(error.localizedDescription)
                            completionBlock(nil, "internet error")
                        }else if let data = data{
                            let reset = try? jsonDecoder.decode(ResetPasswordResponseModel.self,from: data)
                            if reset?.data != nil{
                                if  (reset?.code)! == 200{
                                    completionBlock(reset, nil)
                                }else{
                                 completionBlock(nil, reset?.message!)
                                }
                            }else{
                                completionBlock(nil,"internet error")
                            }
                        }
                    }catch{
                    }
                }
                task.resume()
            }catch{
            }
        }
    
    //MARK: Change Password
    func changePassword(body : Dictionary<String,String>, completionBlock : @escaping(ChangePasswordResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + CHANGE_PASSWORD_URL)
        do {
            let request  = getRequest(url: url!, method: .post, auth: false, accept: .json, Content_Type: .json, body: body)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        if let reset = try? jsonDecoder.decode(ChangePasswordResponseModel.self,from: data){
                            if  (reset.code)! == 200{
                                completionBlock(reset, nil)
                            }else{
                                completionBlock(nil, (reset.message)!)
                            }
                        }else{
                            completionBlock(nil, "the process unsuccessful")
                        }
                    }
                }catch{
                }
            }
            task.resume()
        }catch{
        }
    }
    
    //MARK: Change Password
    func dashBoardFeed(body : Dictionary<String,Any>, completionBlock : @escaping(DashBoardFeedResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + DASHBOARD_FEED_URL)
        do {
            let request  = getRequest(url: url!, method: .post, auth: true, accept: .json, Content_Type: .json, body: body)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        if let reset = try? jsonDecoder.decode(DashBoardFeedResponseModel.self,from: data){
                            if  (reset.code)! == 200{
                                completionBlock(reset, nil)
                            }else{
                                completionBlock(nil, (reset.message)!)
                            }
                        }else{
                            completionBlock(nil, "the process unsuccessful")
                        }
                    }
                }catch{
                }
            }
            task.resume()
        }catch{
        }
    }
    
    //JOBS_LIST_URL//search_word=web developer,job_type=freelance,state=Kerala
    //MARK: Job List
    func jobsList(body : Dictionary<String,String>,completionBlock : @escaping(JobsPageListResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + JOB_LIST_URL)
        do {
            let request  = getRequest(url: url!, method: .post, auth: true, accept: .json, Content_Type: .json, body: body)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(JobsPageListResponseModel.self,from: data)
                        if user?.data != nil{
                            if  (user?.code)! == 200{
                                completionBlock(user, nil)
                            }else{
                                completionBlock(nil, user?.message)
                            }
                        }else{
                            completionBlock(nil,"internet error")
                        }
                    }
                }catch{
                }
            }
            task.resume()
        }catch{
        }
    }
    //DIRECTORY_MEMBER_DETAIL
    func directoryProfile(body : Dictionary<String,String>,completionBlock : @escaping(DirectoryProfileResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + DIRECTORY_MEMBER_DETAIL)
        do {
            let request  = getRequest(url: url!, method: .post, auth: true, accept: .json, Content_Type: .json, body: body)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(DirectoryProfileResponseModel.self,from: data)
                        if user?.data != nil{
                            if  (user?.code)! == 200{
                                completionBlock(user, nil)
                            }else{
                                completionBlock(nil, user?.message)
                            }
                        }else{
                            completionBlock(nil,"internet error")
                        }
                    }
                }catch{
                }
            }
            task.resume()
        }catch{
        }
    }
}
