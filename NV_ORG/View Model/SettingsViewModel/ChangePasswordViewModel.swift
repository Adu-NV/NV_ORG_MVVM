//
//  ChangePasswordViewModel.swift
//  NV_ORG
//
//  Created by Netventure on 27/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class ChangePasswordViewModel{
    public var resetRequest : ChangePasswordRequestModel
    public var delegate : ChangePasswordViewControllerDelegateProtocol?
    init() {
        self.resetRequest = ChangePasswordRequestModel(_current: "", _new: "", _confirm: "")
    }
    
}

extension ChangePasswordViewModel : ChangePasswordViewModelDelegateProtocol{
    func sendnewPassword(from old: String?, to password: String?, confirm_password: String?) {
        if old!.isEmpty && password!.isEmpty && confirm_password!.isEmpty{
            delegate?.sendInformationBack(success: false, message: INVALID,model: nil)
        }else if  old!.isEmpty || password!.isEmpty || confirm_password!.isEmpty{
            delegate?.sendInformationBack(success: false, message: INVALID,model: nil)
        }else{
            if password == confirm_password{
                self.resetRequest = ChangePasswordRequestModel(_current: old!, _new:password!, _confirm: confirm_password!)
                delegate?.sendInformationBack(success: true, message: nil, model: resetRequest.updateDic)
            }else{
                delegate?.sendInformationBack(success: false, message: PASSWORD_MISMATCH,model: nil)
            }
        }

    }
    
    func moveToSuccessPage(viewController: UIViewController) {
        //do coding here
        debugPrint("Sucess")
    }
    
    func skipButtontapped(view: UIViewController) {
        if #available(iOS 13.0, *) {
            if let navController = view.navigationController {
                navController.popViewController(animated: true)
            }
        }else{
            view.dismiss(animated: false, completion: nil)
        }
    }
    
    
}

