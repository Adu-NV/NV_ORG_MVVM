//
//  LoginViewController.swift
//  NV_ORG
//
//  Created by Netventure on 17/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField : UITextField!{
        didSet{
            guard let field = self.emailTextField   else { return }
            field.placeholder = "Username"
            field.text = "adarsh@netventure.in"
        }
    }
    @IBOutlet weak var passwordTextField : UITextField!{
        didSet{
            guard let field = self.passwordTextField  else { return }
            field.placeholder = "Password"
//            field.text = "adarsh@netventure.in"
        }
    }
    @IBOutlet weak var loginViewCenterConstraint : NSLayoutConstraint!{
        didSet{
            guard let field = self.loginViewCenterConstraint  else { return }
            field.constant = 15.0
        }
    }
    
    @IBOutlet weak var loginButton : LoadingButton!
    var loginViewModel = LoginViewModel()
    internal var delegate  : LoginViewDelegateProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        let _tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(_tap)
    }
    
    @objc func keyboardShow(notification:Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            _ = keyboardRectangle.height
            self.loginViewCenterConstraint.constant = -50 //keyboardHeight - 50
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func keyboardHide(notification:Notification){
        self.loginViewCenterConstraint.constant = 15
        UIView.animate(withDuration: 0.5) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func setupUI(){
        loginViewModel.delegate = self
        self.loginButton.setCornerRadius(radius: 6.0, bg_Color: BUTTON_LOGIN_COLOR)
    }
    
    func clearText(){
        emailTextField.text = ""
        passwordTextField.text = ""
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        loginViewModel.sendValue(from: emailTextField.text!, passwordTextField: passwordTextField.text!)
        self.dismissKeyboard()
    }
    
    @IBAction func forgotPasswordButtontapped(_ sender: Any) {
        loginViewModel.moveToEmailVerification(viewController: self)
    }
}

extension LoginViewController: LoginViewControllerDelegate{
    func getInformationBack(success: Bool, message: String?, model: Dictionary<String,String>?) {
        if !success{
            showAlert(message!)
        }else{
            callLoginApi(model!)
        }
    }
    
    func showAlert(_ message : String){
        let alertController = UIAlertController()
        alertController.simpAler(title: APPLICATION_NAME, message: message, isOkButton: true, isCancelButton: false, okButtonText: OK_TEXT, cancelbuttonText: nil, preferredStyle: .alert)
    }
    
    func callLoginApi(_ body : [String:String]){
        DispatchQueue.main.async {
            self.loginButton.showLoading()
            Webservice.shared.Login(body: body) { (model,message)  in
                self.loginButton.hideLoading()
                if model != nil{
                    self.loginViewModel.moveToOtppage(viewController: self)
                }else{
                    if message == LOGIN_ERROR_MESSAGE{
                        self.showAlert(message!)
                    }else{
                        self.showAlert(INVALID_LOGIN_MESSAGE)
                    }
                 }
            }
        }
    }
    
}
