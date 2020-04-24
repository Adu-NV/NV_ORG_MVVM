//
//  ChangePasswordViewController.swift
//  NV_ORG
//
//  Created by Netventure on 27/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonchnage: LoadingButton!
    @IBOutlet weak var currenttextField: UITextField!
    @IBOutlet weak var newTextField: UITextField!
    @IBOutlet weak var confirmTextfield: UITextField!
    
    internal var changeDelegate : ChangePasswordViewModelDelegateProtocol!
    var changeViewmodel = ChangePasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        let _tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(_tap)
        setUI()
    }
    
    @IBAction func buttonChangeTapped(_ sender: UIButton) {
        self.changeViewmodel.sendnewPassword(from: currenttextField.text!, to: newTextField.text!, confirm_password: confirmTextfield.text!)
    }
    @IBAction func buttonBackTapped(_ sender: Any) {
        self.changeViewmodel.skipButtontapped(view: self)
    }
}

    //MARK:- Keyboard Actions and custom functions
extension ChangePasswordViewController{
    
    func setUI(){
        self.changeViewmodel.delegate = self
        self.buttonchnage.setCornerRadius(radius: 6.0, bg_Color: BUTTON_LOGIN_COLOR)
    }
    
    @objc func keyboardShow(notification:Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            _ = keyboardFrame.cgRectValue
            self.centerConstraint.constant = -50
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func keyboardHide(notification:Notification){
        self.centerConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension ChangePasswordViewController: ChangePasswordViewControllerDelegateProtocol{
    func sendInformationBack(success: Bool, message: String?, model: Dictionary<String, String>?) {
        if success{
            Webservice.shared.changePassword(body: model!) { (model, error) in
                if (model?.message)! == SUCCESS_STRING{
                    self.changeViewmodel.moveToSuccessPage(viewController: self)
                }else{
                    self.showAlert((model?.message)!)
                }
            }
        }else{
            self.showAlert(message!)
        }
    }
    
    func showAlert(_ message:String){
        let alertController = UIAlertController()
        alertController.simpAler(title: APPLICATION_NAME, message: message, isOkButton: true, isCancelButton: false, okButtonText: OK_TEXT, cancelbuttonText: nil, preferredStyle: .alert)
    }
}
