//
//  OTPViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 19/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class OTPViewModel{
    public var otpRequest : OTPRequestModel
    public var delegate : OTPViewControllerDelegateProtocol?
    public var timer : Timer?
    public var timeCount = 0
    init() {
        timer = Timer()
        self.otpRequest = OTPRequestModel(_deviceType: "",_otp: "",_user_id: "")
    }
}

extension OTPViewModel: OTPViewModelDelegateProtocol{
    func backButtontapped(view : UIViewController) {
        if #available(iOS 13.0, *) {
            if let navController = view.navigationController {
                navController.popViewController(animated: true)
            }
        }else{
            view.dismiss(animated: false, completion: nil)
        }
    }
    
    func sendOTP(from otpField1: String?, otpField2: String?, otpField3: String?, otpField4: String?, otpField5: String?, otpField6: String?) {
        if otpField1!.isEmpty || otpField2!.isEmpty || otpField3!.isEmpty || otpField4!.isEmpty || otpField5!.isEmpty || otpField6!.isEmpty{
            delegate?.sendInformationBack(success: false, message: INVALID_OTP, model: nil)
        }else{
            let otp = otpField1! + otpField2! + otpField3! + otpField4! + otpField5! + otpField6!
            otpRequest = OTPRequestModel(_deviceType: DEVICE_TYPE, _otp: otp, _user_id: "\((UserDefaults.standard.value(forKey: "userID") as! Int))")
            delegate?.sendInformationBack(success: true, message: nil, model: otpRequest.updateDic)
        }
    }
    
    func moveToDashBoard(viewController: UIViewController) {
        let storyboardValue = UIStoryboard.init(name: "Main", bundle: nil)
        let main =  storyboardValue.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
        main.setUPViewController()
        if #available(iOS 13.0, *) {
                            let aObjNavi = UINavigationController(rootViewController: main)
            aObjNavi.isNavigationBarHidden = true
                             viewController.present(aObjNavi, animated: false, completion: nil)
//            viewController.navigationController?.pushViewController(main, animated: false)
        }else{
            viewController.present(main, animated: false, completion: nil)
        }
    }
    
    func startTimer() {
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer()
    {
        timeCount += 1
        if timeCount > 30 {
            delegate?.stopTimerAndVisibleButton()
        }
    }
    
}
