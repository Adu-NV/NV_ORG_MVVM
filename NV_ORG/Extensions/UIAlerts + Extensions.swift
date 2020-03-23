//
//  UIAlerts + Extensions.swift
//  NV_ORG
//
//  Created by Netventure on 18/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit


extension UIAlertController{
    
    func simpAlertWith_TwoButtons(title :String , message: String ,okButtonText : String , cancelbuttonText : String,preferredStyle :UIAlertController.Style){
        let currentTopVC: UIViewController? =  ((UIApplication.shared.delegate) as! AppDelegate).currentTopViewController()
        let alert = UIAlertController(title: title, message:message, preferredStyle:preferredStyle)
        alert.addAction(UIAlertAction(title: okButtonText ,style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: cancelbuttonText, style: .cancel, handler: nil))
        currentTopVC!.present(alert, animated: true, completion: nil)
    }
    func simpAler(title :String , message: String ,isOkButton: Bool,isCancelButton: Bool,okButtonText : String? , cancelbuttonText : String?,preferredStyle :UIAlertController.Style){
        DispatchQueue.main.async {
            let currentTopVC: UIViewController? =  ((UIApplication.shared.delegate) as! AppDelegate).currentTopViewController()
            let alert = UIAlertController(title: title, message:message, preferredStyle:preferredStyle)
            if isOkButton{
                alert.addAction(UIAlertAction(title: okButtonText ,style: .default, handler: nil))
            }
            if isCancelButton{
                alert.addAction(UIAlertAction(title: cancelbuttonText, style: .cancel, handler: nil))
            }
            currentTopVC!.present(alert, animated: true, completion: nil)
        }
    }
    
}


