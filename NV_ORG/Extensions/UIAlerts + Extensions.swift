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
        if #available(iOS 13, *){
            alert.modalPresentationStyle = .overCurrentContext
            self.parent!.present(alert, animated: true, completion: nil)
        }else{
            currentTopVC!.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func simpAler(title :String , message: String ,isOkButton: Bool,isCancelButton: Bool,okButtonText : String? , cancelbuttonText : String?,preferredStyle :UIAlertController.Style){
        DispatchQueue.main.async {
            let currentTopVC: UIViewController? =  ((UIApplication.shared.delegate) as! AppDelegate).currentTopViewController()
            var _alert = self
            _alert = UIAlertController(title: title, message:message, preferredStyle:preferredStyle)
           
            if isOkButton{
               _alert.addAction(UIAlertAction(title: okButtonText ,style: .default, handler: nil))
            }
            if isCancelButton{
                _alert.addAction(UIAlertAction(title: cancelbuttonText, style: .cancel, handler: nil))
            }
            DispatchQueue.main.async(execute: {
                if #available(iOS 13, *){
                    _alert.modalPresentationStyle = .overCurrentContext
                    self.parent!.present(_alert, animated: true, completion: nil)
                }else{
                    currentTopVC!.present(_alert, animated: true, completion: nil)
                }
            })

        }
    }
    func simpAlert(title :String , message: String ,isOkButton: Bool,isCancelButton: Bool,okButtonText : String? , cancelbuttonText : String?,preferredStyle :UIAlertController.Style,completionBlock : @escaping(Bool,Bool) -> ()){
        DispatchQueue.main.async {
            let currentTopVC: UIViewController? =  ((UIApplication.shared.delegate) as! AppDelegate).currentTopViewController()
            let alert = UIAlertController(title: title, message:message, preferredStyle:preferredStyle)
            if isOkButton{
                alert.addAction(UIAlertAction(title: okButtonText, style: .default, handler: { (action) in
                    completionBlock(true,false)
                }))
            }
            if isCancelButton{
                alert.addAction(UIAlertAction(title: cancelbuttonText, style: .cancel, handler: { (action) in
                    completionBlock(false,true)
                }))
            }
            if #available(iOS 13, *){
                alert.modalPresentationStyle = .overCurrentContext
                self.parent!.present(alert, animated: true, completion: nil)
            }else{
                currentTopVC!.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}



//class GlobalAlertController: UIAlertController {
//      
//    var globalPresentationWindow: UIWindow?
//      
//    func presentGlobally(animated: Bool, completion: (() -> Void)?) {
//        globalPresentationWindow = UIWindow(frame: UIScreen.main.bounds)
//        globalPresentationWindow?.rootViewController = LightStatusBarController()
//        globalPresentationWindow?.windowLevel = UIWindow.Level.alert + 1
//        globalPresentationWindow?.backgroundColor = .clear
//        globalPresentationWindow?.makeKeyAndVisible()
//        globalPresentationWindow?.rootViewController?.present(self, animated: animated, completion: completion)
//    }
//      
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        globalPresentationWindow?.isHidden = true
//        globalPresentationWindow = nil
//    }
//  
//}
