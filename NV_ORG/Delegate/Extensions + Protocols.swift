//
//  Extensions + Protocols.swift
//  NV_ORG
//
//  Created by Netventure on 17/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit


// MARK:- Login Delegates

public protocol LoginViewDelegateProtocol{
    func sendValue(from emailTextField: String?, passwordTextField: String?)
    func moveToOtppage(viewController : UIViewController)
    func moveToEmailVerification(viewController : UIViewController)
}

public protocol LoginViewControllerDelegate{
    func getInformationBack(success:Bool , message: String?,model: Dictionary<String,String>?)
}

// MARK:- OTP Delegates

public protocol OTPViewModelDelegateProtocol{
    func sendOTP(from otpField1 : String?,otpField2 : String?,otpField3 : String?,otpField4 : String?,otpField5 : String?,otpField6 : String?)
    func moveToDashBoard(viewController : UIViewController)
    func backButtontapped(view : UIViewController)
    func startTimer()
}

public protocol OTPViewControllerDelegateProtocol{
    func sendInformationBack(success:Bool , message: String?,model: Dictionary<String,String>?)
    func stopTimerAndVisibleButton()
}

// MARK:- EmailVerification Delegates

public protocol EmailCheckDelegateProtocol{
    func sendEmail(from email: String?)
    func moveToResetOTP(viewController : UIViewController, otp :String )
    func backButtontapped(view : UIViewController)
}
public protocol EmailCheckViewControllerDelegateProtocol{
    func sendInformationBack(success:Bool , message: String?,model: Dictionary<String,String>?)
}


// MARK:- Reset OTP Delegates

public protocol ResetOTPViewModelDelegateProtocol{
    func sendOTP(from otpField1 : String?,otpField2 : String?,otpField3 : String?,otpField4 : String?,otpField5 : String?,otpField6 : String?,otp :String)
    func moveToDashBoard(viewController : UIViewController)
    func backButtontapped(view : UIViewController)
}

public protocol EmailOTPViewControllerDelegateProtocol{
    func sendInformationBack(success:Bool , message: String?)
}

// MARK:- Reset Password Delegates

public protocol ResetPasswordViewModelDelegateProtocol{
    func sendPassword(from password: String?,confirm_password : String?)
    func moveToLoginPage(viewController : UIViewController)
    func skipButtontapped(view : UIViewController)
}

public protocol ResetPasswordViewControllerDelegateProtocol{
    func sendInformationBack(success:Bool , message: String?,model : Dictionary<String,String>?)
}
