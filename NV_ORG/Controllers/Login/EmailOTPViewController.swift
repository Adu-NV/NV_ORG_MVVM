//
//  EmailOTPViewController.swift
//  NV_ORG
//
//  Created by Netventure on 19/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class EmailOTPViewController: UIViewController {

    var email : String? = nil
        @IBOutlet weak var centerConstraint: NSLayoutConstraint!       {
            didSet{
                guard let field = self.centerConstraint  else { return }
                field.constant = 5.0
            }
        }
        @IBOutlet weak var verifyButton: LoadingButton!
        
        @IBOutlet weak var backButton: UIButton!
        @IBOutlet weak var textField1: LineTextField!{
            didSet{
                guard let field = self.textField1  else { return }
                field.placeholder = "*"
                }
        }
        @IBOutlet weak var textField2: LineTextField!{
            didSet{
                guard let field = self.textField2  else { return }
                field.placeholder = "*"
                }
        }
        @IBOutlet weak var textField3: LineTextField!{
            didSet{
                guard let field = self.textField3  else { return }
                field.placeholder = "*"
                }
        }
        @IBOutlet weak var textField4: LineTextField!{
            didSet{
                guard let field = self.textField4  else { return }
                field.placeholder = "*"
                }
        }
        @IBOutlet weak var textField5: LineTextField!{
            didSet{
                guard let field = self.textField5  else { return }
                field.placeholder = "*"
                }
        }
        @IBOutlet weak var textField6: LineTextField!{
            didSet{
                guard let field = self.textField6  else { return }
                field.placeholder = "*"
                }
        }
        var otpViewModel = ResetOTPViewModel()
        internal var delegate  : ResetOTPViewModelDelegateProtocol!
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

        //MARK:- Button Actions
        
        @IBAction func buttonEnterTapped(_ sender: UIButton) {
            DispatchQueue.main.async {
                self.verifyButton.showLoading()
                Webservice.shared.OTPSubmit(body: self.model, completionBlock: { (model, message) in
                    self.verifyButton.hideLoading()
                    if model != nil{
                        self.otpViewModel.moveToDashBoard(viewController: self)
                    }else{
                        if message == LOGIN_ERROR_MESSAGE{
                            self.showAlert(message!)
                        }else{
                            self.showAlert(INVALID_LOGIN_MESSAGE)
                        }
                    }
                })
             }
        }

        
        @IBAction func backButtonTapped(_ sender: Any) {
            otpViewModel.backButtontapped(view: self)
        }
    }

        //MARK:- Keyboard Actions
    extension EmailOTPViewController{
        
        @objc func keyboardShow(notification:Notification){
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                _ = keyboardFrame.cgRectValue
    //            let keyboardHeight = keyboardRectangle.height
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

        //MARK:- TextFieldDelegate
    extension EmailOTPViewController: UITextFieldDelegate{
        func checkAllFields(){
            otpViewModel.sendOTP(from: textField1.text, otpField2: textField2.text, otpField3: textField3.text, otpField4: textField4.text, otpField5: textField5.text, otpField6: textField6.text, otp: email!)
            buttonEnterTapped(verifyButton)
        }
        
        @objc func textFieldDidChange(textField: UITextField){
            let text = textField.text
            if (text?.utf16.count)! >= 1{
                switch textField.tag{
                case 0:
                    textField2.becomeFirstResponder()
                case 1:
                    textField3.becomeFirstResponder()
                case 2:
                    textField4.becomeFirstResponder()
                case 3:
                    textField5.becomeFirstResponder()
                case 4:
                    textField6.becomeFirstResponder()
                case 5:
                    textField6.resignFirstResponder()
                    checkAllFields()
                default:
                    break
                }
            }else{
            }
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.text = ""
        }
    }

        //MARK:- Delegate
extension EmailOTPViewController : EmailOTPViewControllerDelegateProtocol{
    func sendInformationBack(success: Bool, message: String?) {
        if success{
            otpViewModel.moveToDashBoard(viewController: self)
        }else{
            self.showAlert(message!)
        }
    }
    


    }

        //MARK:- UserDefined functions
    extension EmailOTPViewController{
        func setUI(){
            otpViewModel.delegate = self
            verifyButton.setCornerRadius(radius: 6.0, bg_Color: BUTTON_LOGIN_COLOR)
            
            
            textField1.isSecureTextEntry = true
            textField1.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            textField2.isSecureTextEntry = true
            textField2.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            textField3.isSecureTextEntry = true
            textField3.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            textField4.isSecureTextEntry = true
            textField4.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            textField5.isSecureTextEntry = true
            textField5.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            textField6.isSecureTextEntry = true
            textField6.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
        }
        
        func showAlert(_ message:String){
            let alertController = UIAlertController()
            alertController.simpAler(title: APPLICATION_NAME, message: message, isOkButton: true, isCancelButton: false, okButtonText: OK_TEXT, cancelbuttonText: nil, preferredStyle: .alert)
        }
}
