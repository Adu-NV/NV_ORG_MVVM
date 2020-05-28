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

// MARK:- Change Password Delegates

public protocol ChangePasswordViewModelDelegateProtocol{
    func sendnewPassword(from old: String? ,to password: String?,confirm_password : String?)
    func moveToSuccessPage(viewController : UIViewController)
    func skipButtontapped(view : UIViewController)
}

public protocol ChangePasswordViewControllerDelegateProtocol{
    func sendInformationBack(success:Bool , message: String?,model : Dictionary<String,String>?)
}

// MARK:- DashBoard Delegates

public protocol DashBoardViewModelDelegateProtocol{
    func moveToMenuPage(viewController : UIViewController ,model:DashBoardResponseModel?)
    func skipButtontapped(view : UIViewController)
    mutating func setDashBoardCell(model : DashBoardResponseData)
}

public protocol DashBoardViewModelViewControllerDelegateProtocol{
}

// MARK:- Menu Delegates
public protocol MenuViewModelDelegateProtocol{
    func skipButtontapped(view : UIViewController)
    func moveToPage(from viewController : UIViewController,index : Int)
    func moveToLogin()
}

public protocol MenuViewControllerDelegateProtocol{
    func didCallSignOutAPI()
}

// MARK:- Homefeed Delegates
public protocol HomeFeedSettingsViewModelDelegateProtocol{
    func setdashBoardFeedModel(model:DashBoardResponseModel)
    func skipButtontapped(view : UIViewController)
}

public protocol HomeFeedSettingsViewControllerDelegateProtocol{
}

// MARK:- Notification Delegates
public protocol NotificationSettingsViewModelDelegateProtocol{
    func skipButtontapped(view : UIViewController)
}

public protocol NotificationSettingsViewControllerDelegateProtocol{
}

// MARK:- About Delegates
public protocol AboutViewModelDelegateProtocol{
    func skipButtontapped(view : UIViewController)
}
public protocol AboutUsViewControllerDelegateProtocol{
}

// MARK:- Privacy Delegates
public protocol PrivacyViewModelDelegateProtocol{
    func skipButtontapped(view : UIViewController)
}
public protocol PrivacyPolicyViewControllerDelegateProtocol{
}

// MARK:- Leadership Delegates
public protocol LeaderShipViewModelDelegateProtocol{
    func skipButtontapped(view : UIViewController)
}
public protocol LeaderShipViewControllerDelegateProtocol{
}

// MARK:- ProfileViewController Delegates
public protocol ProfileViewModelDelegateProtocol{
        func setProfileModel(model:UserDetailsResponseModel)
    func edittapped(view : UIViewController)
}
public protocol ProfileViewControllerDelegateProtocol{
}


//MARK:- NewsListPageControllerDelegate

public protocol NewsListPageViewModelDelegateProtocol{
    func skipButtontapped(view : UIViewController)
}
public protocol NewsListPageDelegateProtocol{
    
}

//MARK:- DirectoryViewModelDelegateProtocol

public protocol DirectoryViewModelDelegateProtocol{
    func setUpModel(model : DirectoryListResponseModel)
}
public protocol DirectoryViewControllerDelegateProtocol{
}

//MARK:- DirectoryFilterViewModelDelegateProtocol

public protocol DirectoryFilterViewModelDelegateProtocol{
    func skipButtontapped(view : UIViewController)
    func filterButtonTapped(view : UIViewController , location : String,country : String , position: String)
}
public protocol DirectoryFilterViewControllerDelegateProtocol{
}


//MARK:- TableViewButtonDelegate

public protocol TableViewButtonTapped{
    func buttonTapped(sender : UIButton)
}
public protocol TableViewTouchDelegate{
    func touchInitiated(row : Int)
}


public protocol DirectoryFilterDelegate{
    func didSelect(_dic : Dictionary<String,String> ,viewController : UIViewController)
}
public protocol DateDelegate{
    func didSelect(date: String)
}

public protocol NewsListProtocol{
    func didSelectNews(news_dates : String ,viewController : UIViewController)
}
