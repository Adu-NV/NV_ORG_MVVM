//
//  LoginViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 18/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

struct LoginViewModel{
    public var login : LoginRequestModel
    public var delegate : LoginViewControllerDelegate?
    
    init() {
        self.login = LoginRequestModel(_deviceType: "", _password: "", _username: "")
    }
}

extension LoginViewModel : LoginViewDelegateProtocol{
    func moveToEmailVerification(viewController: UIViewController) {
        DispatchQueue.main.async{
            let storyboardValue = UIStoryboard.init(name: "Main", bundle: nil)
            let email =  storyboardValue.instantiateViewController(withIdentifier: "EmailCheckViewController") as! EmailCheckViewController
            if #available(iOS 13.0, *) {
                email.modalPresentationStyle = .fullScreen
                viewController.present(email, animated: true)
            }else{
                viewController.present(email, animated: false, completion: nil)
            }
        }
    }
    
    func moveToOtppage(viewController : UIViewController) {
        DispatchQueue.main.async{
            let storyboardValue = UIStoryboard.init(name: "Main", bundle: nil)
            let otpPage =  storyboardValue.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            if #available(iOS 13.0, *) {
                otpPage.modalPresentationStyle = .fullScreen
                viewController.present(otpPage, animated: true)
            }else{
                viewController.present(otpPage, animated: false, completion: nil)
            }
        }
        
    }
    
    
    func sendValue(from emailTextField: String?, passwordTextField: String?) {
        if emailTextField!.isEmpty && passwordTextField!.isEmpty{
            delegate?.getInformationBack(success: false, message: INVALID_LOGIN, model: nil)
        }else if emailTextField!.isEmpty{
            delegate?.getInformationBack(success: false, message: INVALID_USER, model: nil)
        }else if passwordTextField!.isEmpty{
            delegate?.getInformationBack(success: false, message: INVALID_PASSWORD, model: nil)
        }else{
            let login = LoginRequestModel(_deviceType: DEVICE_TYPE, _password: passwordTextField!, _username: emailTextField!)
            delegate?.getInformationBack(success: true, message: nil, model:login.dictionary)
        }
    }
    
}














