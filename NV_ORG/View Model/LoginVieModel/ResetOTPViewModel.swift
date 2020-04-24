//
//  ResetOTPViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 20/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class ResetOTPViewModel{
    public var delegate : EmailOTPViewControllerDelegateProtocol?
    init() {
    }
}

extension ResetOTPViewModel: ResetOTPViewModelDelegateProtocol{
    func backButtontapped(view : UIViewController) {
        if #available(iOS 13.0, *) {
            if let navController = view.navigationController {
                navController.popViewController(animated: true)
            }
        }else{
            view.dismiss(animated: false, completion: nil)
        }
    }
    
    func sendOTP(from otpField1: String?, otpField2: String?, otpField3: String?, otpField4: String?, otpField5: String?, otpField6: String? ,otp :String) {
        if otpField1!.isEmpty || otpField2!.isEmpty || otpField3!.isEmpty || otpField4!.isEmpty || otpField5!.isEmpty || otpField6!.isEmpty{
            delegate?.sendInformationBack(success: false, message: INVALID_OTP)
        }else{
            let otp1 = otpField1! + otpField2! + otpField3! + otpField4! + otpField5! + otpField6!
            if otp1 == otp{
                delegate?.sendInformationBack(success: true, message: nil)
                UserDefaults.standard.set(otp, forKey: "reset_token")
            }else{
                delegate?.sendInformationBack(success: false, message: INVALID_OTP_INCORRECT)
            }
        }
    }
    
    func moveToDashBoard(viewController: UIViewController) {
        DispatchQueue.main.async{
            let storyboardValue = UIStoryboard.init(name: "Main", bundle: nil)
            let email =  storyboardValue.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
            if #available(iOS 13.0, *) {
                viewController.navigationController?.pushViewController(email, animated: false)
            }else{
                viewController.present(email, animated: false, completion: nil)
            }
        }
        debugPrint("reset OTP Page")
    }
}
