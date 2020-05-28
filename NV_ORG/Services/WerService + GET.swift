//
//  WerService + GET.swift
//  NV_ORG
//
//  Created by Netventure on 18/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

enum NetworkRequestContentType : String {
    case json       = "application/json"
    case urlEncoded = "application/x-www-form-urlencoded"
    case text       = "text/html; charset=UTF-8"
}

enum NetworkRequestMethod : String {
    case get    = "GET"
    case put    = "PUT"
    case post   = "POST"
    case delete = "DELETE"
}

class Webservice{
    static let shared = Webservice()
    
    func getRequest(url : URL?, method : NetworkRequestMethod, auth : Bool? , accept: NetworkRequestContentType?, Content_Type :NetworkRequestContentType? ,body: Dictionary<String,Any>?) -> URLRequest{
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        request.setValue(Content_Type?.rawValue, forHTTPHeaderField: "Content-Type")
        request.setValue(accept?.rawValue, forHTTPHeaderField: "Accept")
        if auth!{
            let str = "\(UserDefaults.standard.value(forKey:  "token_type")as! String)" + " " + "\(UserDefaults.standard.value(forKey:  "token")as! String)"
            request.setValue( str, forHTTPHeaderField: "Authorization" )
        }
        if body != nil {
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                 request.httpBody = jsonData
            }catch{
            }
        }
       return request
    }
    
     //MARK: Sign-out Request
    func signOutRequest(completionBlock : @escaping(SignOutResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + SIGN_OUT_URL)
        do {
            let request  = getRequest(url: url!, method: .get, auth: false, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let otp = try? jsonDecoder.decode(SignOutResponseModel.self,from: data)
                        if otp?.data != nil{
                            if  (otp?.code)! == 200{
                                completionBlock(otp, nil)
                            }else{
                                completionBlock(nil, otp?.message)
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
    
    //MARK: Dashboard Request
    func dsashBoardRequest(completionBlock : @escaping(DashBoardResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + DASHBOARD_URL)
        do {
            let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let otp = try? jsonDecoder.decode(DashBoardResponseModel.self,from: data)
                        if otp?.data != nil{
                            if  (otp?.code)! == 200{
                                UserDefaults.standard.set((otp?.data?.user_state)!, forKey: "state")
                                completionBlock(otp, nil)
                            }else{
                                completionBlock(nil, otp?.message)
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
    
    
    //MARK: ProfileRequest
    func profileRequest(completionBlock : @escaping(UserDetailsResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + USERDETAILS_URL)
        do {
            let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(UserDetailsResponseModel.self,from: data)
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
    
    //MARK: NewsList
    func newsList(completionBlock : @escaping(NewsListpageResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + NEWS_LIST_URL)
        do {
            let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(NewsListpageResponseModel.self,from: data)
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
    
    
    func  getDirectoryLis(completionBlock : @escaping(DirectoryListResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + DIRECTORY_LIST_URL)
        do {
            let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(DirectoryListResponseModel.self,from: data)
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
    //DIRECTORY_FILTER_LIST
    
    func  getDirectoryFilterList(completionBlock : @escaping(DirectoryFilterResponseModel?,String?) -> ()){
        
        let url = URL(string : BASE_URL + DIRECTORY_FILTER_LIST)
        do {
            let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(DirectoryFilterResponseModel.self,from: data)
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
    //GALLERY_LIST_URL
    
    func  getGalleryList(completionBlock : @escaping(GalleryListResponseModel?,String?) -> ()){
        
        let url = URL(string : BASE_URL + GALLERY_LIST_URL)
        do {
            let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(GalleryListResponseModel.self,from: data)
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
    
        //GALLERY_LIST_URL
    //NotificationListResponseModel
    
    func  getNotificationList(tag : Int ,completionBlock : @escaping(NotificationListResponseModel?,String?) -> ()){
        let urlSubString = tag == 0 ? NOTIFICATION_LIST_URL : ANNOUNCEMENT_LIST_URL
        let url = URL(string : BASE_URL + urlSubString)
        do {
            let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(NotificationListResponseModel.self,from: data)
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
    
    func  getJobDetail(id : String ,completionBlock : @escaping(JobDetailResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + JOB_DETAIL_URL + id)
        do {
            let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(JobDetailResponseModel.self,from: data)
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
    
    
    //CELEBRATION_LIST_URL
    func  getCelebrationList(completionBlock : @escaping(CelebrationListResponseModel?,String?) -> ()){
          let url = URL(string : BASE_URL + CELEBRATION_LIST_URL)
          do {
              let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
              let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                  let jsonDecoder = JSONDecoder()
                  do{
                      if let error = error{
                          debugPrint(error.localizedDescription)
                          completionBlock(nil, "internet error")
                      }else if let data = data{
                          let user = try? jsonDecoder.decode(CelebrationListResponseModel.self,from: data)
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
        
    //JOBtypes
    func  getJobTypesList(completionBlock : @escaping(JobTypeResponseModel?,String?) -> ()){
          let url = URL(string : BASE_URL + JOB_TYPES_URL)
          do {
              let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
              let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                  let jsonDecoder = JSONDecoder()
                  do{
                      if let error = error{
                          debugPrint(error.localizedDescription)
                          completionBlock(nil, "internet error")
                      }else if let data = data{
                          let user = try? jsonDecoder.decode(JobTypeResponseModel.self,from: data)
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
    
    //MEETINGS_LIST_URL
    
    func  getMeetingsDetails(id : String ,completionBlock : @escaping(MeetingsDetailsResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + MEETINGS_LIST_URL + id)
        do {
            let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(MeetingsDetailsResponseModel.self,from: data)
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
    
    //NEWS_DATES_URL
    func  getNewsDates(completionBlock : @escaping(NewsDateListResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + NEWS_DATES_URL)
        do {
            let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(NewsDateListResponseModel.self,from: data)
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
    
    
    //NEWS_DATES_URL
    func  getEventsDates(completionBlock : @escaping(NewsDateListResponseModel?,String?) -> ()){
        let url = URL(string : BASE_URL + EVENTS_DATES_URL)
        do {
            let request  = getRequest(url: url!, method: .get, auth: true, accept: .json, Content_Type: .json, body: nil)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                do{
                    if let error = error{
                        debugPrint(error.localizedDescription)
                        completionBlock(nil, "internet error")
                    }else if let data = data{
                        let user = try? jsonDecoder.decode(NewsDateListResponseModel.self,from: data)
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


