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
    
    func getRequest(url : URL?, method : NetworkRequestMethod, auth : Bool? , accept: NetworkRequestContentType?, Content_Type :NetworkRequestContentType? ,body: Dictionary<String,String>?) -> URLRequest{
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        request.setValue(Content_Type?.rawValue, forHTTPHeaderField: "Content-Type")
        request.setValue(accept?.rawValue, forHTTPHeaderField: "Accept")
        if auth!{
            let str = "\(UserDefaults.standard.value(forKey:  "token_type")as! String)" + " " + "\(UserDefaults.standard.value(forKey:  "token")as! String)"
            request.setValue( str, forHTTPHeaderField: "Authorisation" )
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
    
    
}
