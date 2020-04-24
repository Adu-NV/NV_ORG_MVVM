//
//  EmailVerificationViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 19/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class EmailVerificationViewModel{
    public var emailRequest : EmailVerificationRequestModel
    public var delegate : EmailCheckViewControllerDelegateProtocol?
    init() {
        self.emailRequest = EmailVerificationRequestModel(_email: "")
    }
}
extension EmailVerificationViewModel: EmailCheckDelegateProtocol{
    func sendEmail(from email: String?) {
        if email!.isEmpty{
            delegate?.sendInformationBack(success: false, message: INVALID_EMAIL, model: nil)
        }else{
            emailRequest = EmailVerificationRequestModel(_email: email!)
            delegate?.sendInformationBack(success: true, message: nil, model: emailRequest.updateDic)
        }
    }
    
    func moveToResetOTP(viewController: UIViewController , otp : String) {
        //EmailOTPViewController
        DispatchQueue.main.async{
            let storyboardValue = UIStoryboard.init(name: "Main", bundle: nil)
            let email =  storyboardValue.instantiateViewController(withIdentifier: "EmailOTPViewController") as! EmailOTPViewController
            email.email = otp
            if #available(iOS 13.0, *) {
                viewController.navigationController?.pushViewController(email, animated: false)
            }else{
                viewController.present(email, animated: false, completion: nil)
            }
        }
       debugPrint("reset OTP Page")
    }
    
    func backButtontapped(view: UIViewController) {
        if #available(iOS 13.0, *) {
            if let navController = view.navigationController {
                navController.popViewController(animated: true)
            }
        }else{
            view.dismiss(animated: false, completion: nil)
        }
    }
    

    
}
