//
//  EmailCheckViewController.swift
//  NV_ORG
//
//  Created by Netventure on 19/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class EmailCheckViewController: UIViewController {
    
    @IBOutlet weak var emailTextField : LineTextField!{
        didSet{
            guard let field = self.emailTextField else {
                return
            }
            field.placeholder = "Email address"
        }
    }
    
    @IBOutlet weak var checkButton : LoadingButton!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var centerConstraint : NSLayoutConstraint!{
        didSet{
            guard let field = self.centerConstraint else {
                return
            }
            field.constant = 20
        }
    }
    var emailViewModel = EmailVerificationViewModel()
    internal var delegate  : EmailCheckDelegateProtocol!
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
    
    @IBAction func buttonChecktapped(_ sender: Any) {
        emailViewModel.sendEmail(from: emailTextField.text!)
    }
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        emailViewModel.backButtontapped(view: self)
    }
}

extension EmailCheckViewController{
    func setUI(){
        emailViewModel.delegate = self
        self.checkButton.setCornerRadius(radius: 6.0, bg_Color: BUTTON_LOGIN_COLOR)
    }
}


//MARK:- Keyboard Actions
extension EmailCheckViewController{
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
        self.centerConstraint.constant = 20
        UIView.animate(withDuration: 0.5) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension EmailCheckViewController : EmailCheckViewControllerDelegateProtocol{
    func sendInformationBack(success: Bool, message: String?, model: Dictionary<String, String>?) {
        if success{
            self.model = model!
            sendEmail()
        }else{
            self.showAlert(message!)
        }
    }
    
    func showAlert(_ message:String){
        let alertController = UIAlertController()
        if #available(iOS 13, *){
            self.addChild(alertController)
        }
        alertController.simpAler(title: APPLICATION_NAME, message: message, isOkButton: true, isCancelButton: false, okButtonText: OK_TEXT, cancelbuttonText: nil, preferredStyle: .alert)
    }
    
    func sendEmail(){
        DispatchQueue.main.async {
            self.checkButton.showLoading()
            Webservice.shared.EmailVerification(body: self.model) { (model, error) in
                self.checkButton.hideLoading()
                if model != nil{
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(self.emailTextField.text!, forKey: "reset_email")
                    }
                    self.emailViewModel.moveToResetOTP(viewController: self, otp: "\((model!.data?.token)!)")
                }else{
                    self.showAlert(error!)
                }
            }
        }
    }
}
