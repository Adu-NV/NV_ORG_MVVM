//
//  ResetPasswordViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 20/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class ResetPasswordViewModel{
    public var resetRequest : ResetPasswordRequestModel
    public var delegate : ResetPasswordViewControllerDelegateProtocol?
    init() {
        self.resetRequest = ResetPasswordRequestModel(_email: "", _pass: "", _token: "", _confirm: "")
    }
    
}
extension ResetPasswordViewModel: ResetPasswordViewModelDelegateProtocol{
    func sendPassword(from password: String?, confirm_password: String?) {
        if password == confirm_password{
            self.resetRequest = ResetPasswordRequestModel(_email: UserDefaults.standard.value(forKey: "reset_email") as! String, _pass: password!, _token: UserDefaults.standard.value(forKey: "reset_token") as! String, _confirm: confirm_password!)
            delegate?.sendInformationBack(success: true, message: nil, model: resetRequest.updateDic)
        }else{
            delegate?.sendInformationBack(success: false, message: PASSWORD_INCORRECT,model: nil)
        }
    }
    
    func moveToLoginPage(viewController: UIViewController) {
        self.loginPage(viewController: viewController)
    }
    
    func skipButtontapped(view: UIViewController) {
        self.loginPage(viewController: view)
    }
    
    
    func loginPage(viewController: UIViewController){
        DispatchQueue.main.async{
            let storyboardValue = UIStoryboard.init(name: "Main", bundle: nil)
            let login =  storyboardValue.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if #available(iOS 13.0, *) {
                login.modalPresentationStyle = .fullScreen
                viewController.present(login, animated: true)
            }else{
                viewController.present(login, animated: false, completion: nil)
            }
        }
    }
    
}
