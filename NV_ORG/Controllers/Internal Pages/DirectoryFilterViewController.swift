//
//  DirectoryFilterViewController.swift
//  NV_ORG
//
//  Created by Netventure on 29/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit
import DropDown


class DirectoryFilterViewController: UIViewController {
    
    var directoryFilterVM = DirectoryFilterViewModel()
    var picker : UIPickerView? = nil
    var list : [String]? = []
     var delegate : DirectoryFilterDelegate?
    
    @IBOutlet weak var filterApplyButton: UIButton!
    @IBOutlet weak var filterCloseButton: UIButton!
    @IBOutlet weak var filterBottomConstraint: NSLayoutConstraint!
    
    var dropDown = DropDown()
    
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var positionTexField: UITextField!
    @IBOutlet weak var currentLocationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterApplyButton.setCornerRadius(radius: 10.0, bg_Color: BUTTON_LOGIN_COLOR)
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpUI()
        setUpNotification()
    }
    
    func setUpUI(){
        self.dropDown.direction = .any
        self.dropDown.dismissMode = .onTap
       
        Webservice.shared.getDirectoryFilterList { (model, error) in
            if let _ = model{
                self.directoryFilterVM.setModel(model: model!)
            }
        }
    }
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        view.endEditing(true)
        directoryFilterVM.skipButtontapped(view: self)
    }
    @IBAction func filterButtonTapped(_ sender: Any) {
        var dic = Dictionary<String,String>()
        dic["position_in_society"] = positionTexField.text != nil ? positionTexField.text! : ""
         dic["country"] = countryTextField.text != nil ? countryTextField.text! : ""
         dic["location"] = currentLocationTextField.text != nil ? currentLocationTextField.text! : ""
        dic["search_string"] = ""
        delegate?.didSelect(_dic: dic, viewController: self)
    }
}


extension DirectoryFilterViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
  
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.list = []
        let view1 =  UIView(frame: CGRect(x: textField.frame.minX, y: textField.frame.minY, width: textField.frame.width, height: 30))
        
        self.dropDown.anchorView = view1
        self.dropDown.topOffset = CGPoint(x: textField.frame.minX, y:textField.frame.maxX)
        switch textField.tag {
        case 0:
                for i in 0 ..< self.directoryFilterVM.positionList.count{
                list?.append((self.directoryFilterVM.positionList[i].position_name)!)
            }
            self.dropDown.dataSource = list!
            self.dropDown.show()
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
              print("Selected item: \(item) at index: \(index)")
                self.positionTexField.text = item
            }
        case 1:
            for i in 0 ..< self.directoryFilterVM.countryList.count{
                list?.append((self.directoryFilterVM.countryList[i].country_name)!)
            }
            self.dropDown.dataSource = list!
            self.dropDown.show()
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
              print("Selected item: \(item) at index: \(index)")
                self.countryTextField.text = item
            }
        default:
            for i in 0 ..< self.directoryFilterVM.locationsList.count{
                list?.append((self.directoryFilterVM.locationsList[i].current_name)!)
            }
            self.dropDown.dataSource = list!
            self.dropDown.show()
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
              print("Selected item: \(item) at index: \(index)")
                self.currentLocationTextField.text = item
            }
        }
    }
}

extension DirectoryFilterViewController{
    func setUpNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        let _tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(_tap)
    }
    
    @objc func keyboardShow(notification:Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                 let keyboardRectangle = keyboardFrame.cgRectValue
                 let keyboardHeight = keyboardRectangle.height
                  self.filterBottomConstraint.constant  = keyboardHeight
             }else{
                  self.filterBottomConstraint.constant = 250.0
             }
       UIView.animate(withDuration: 0.5) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func keyboardHide(notification:Notification){
        self.filterBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}


