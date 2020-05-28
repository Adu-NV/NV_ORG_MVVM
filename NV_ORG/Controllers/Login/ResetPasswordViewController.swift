//
//  ResetPasswordViewController.swift
//  NV_ORG
//
//  Created by Netventure on 20/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var centerConstraint: NSLayoutConstraint!{
        didSet{
              guard let field = self.centerConstraint else{ return}
              field.constant = 0
          }
    }
    @IBOutlet weak var newPasswordTextField: UITextField!{
        didSet{
            guard let field = self.newPasswordTextField else{ return}
            field.placeholder = "New password"
        }
     }
    @IBOutlet weak var confirmPasswordTextField: UITextField!{
        didSet{
            guard let field = self.confirmPasswordTextField else{ return}
            field.placeholder = " Confirm password"
        }
    }
    @IBOutlet weak var confirmButton: LoadingButton!{
        didSet{
            guard let field = self.confirmButton else{ return}
            field.setTitle("CONFIRM", for: .normal)
        }
    }
    @IBOutlet weak var skipButton: UIButton!{
        didSet{
            guard let field = self.skipButton else{ return}
            field.setTitle("SKIP", for: .normal)
        }
    }
    
    var resetViewModel = ResetPasswordViewModel()
    internal var delegate  : ResetPasswordViewModelDelegateProtocol!
    var model : Dictionary<String,String> = [:]
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
    
    //MARK:- BUtton ACtions
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        resetViewModel.sendPassword(from: newPasswordTextField.text!, confirm_password: confirmPasswordTextField.text!)
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        resetViewModel.moveToLoginPage(viewController: self)
    }
}



 //MARK:- UserDefined Functions
extension ResetPasswordViewController {
    
    func setUI(){
        resetViewModel.delegate = self
        self.confirmButton.setCornerRadius(radius: 6.0, bg_Color: BUTTON_LOGIN_COLOR)
    }
    func showAlert(_ message:String){
        let alertController = UIAlertController()
        if #available(iOS 13, *){
            self.addChild(alertController)
        }
        alertController.simpAler(title: APPLICATION_NAME, message: message, isOkButton: true, isCancelButton: false, okButtonText: OK_TEXT, cancelbuttonText: nil, preferredStyle: .alert)
    }
}


 //MARK:- Keyboard Functions
extension ResetPasswordViewController {
        
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


extension ResetPasswordViewController : ResetPasswordViewControllerDelegateProtocol{
    func sendInformationBack(success: Bool, message: String?, model: Dictionary<String, String>?) {
        if success{
            self.model = model!
            apiCall()
        }else{
            self.showAlert(message!)
        }
    }
    
    func apiCall(){
        DispatchQueue.main.async {
            self.confirmButton.showLoading()
            Webservice.shared.ResetPassword(body: self.model) { (model, error) in
                self.confirmButton.hideLoading()
                if let _ = model{
                    self.resetViewModel.moveToLoginPage(viewController: self)
                }else{
                    self.showAlert(error!)
                }
            }
        }

    }
  
}
