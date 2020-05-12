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
    
    @IBOutlet weak var filterApplyButton: UIButton!
    @IBOutlet weak var filterCloseButton: UIButton!
    
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
    }
    
    func setUpUI(){
        self.dropDown.direction = .any
        self.dropDown.dismissMode = .onTap
       
        Webservice.shared.getDirectoryFilterList { (model, error) in
            if let _ = model{
                self.directoryFilterVM.setModel(model: model!)
            }
        }//getDirectoryFilterList
    }
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        directoryFilterVM.skipButtontapped(view: self)
    }
}


extension DirectoryFilterViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
  
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.list = []
        self.dropDown.anchorView = view
//        self.dropDown.topOffset = CGPoint(x: textField.frame.origin.x, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        self.dropDown.bottomOffset = CGPoint(x: 0, y:textField.frame.maxX)
//        dropDown.topOffset = CGPoint(x: 0, y:textField.frame.minX)
//        dropDown.bottomOffset = CGPoint(x: 0, y:textField.frame.origin.y)
        switch textField.tag {
        case 0:
            
//            dropDown.bottomOffset = CGPoint(x: 0, y:positionTexField.frame.origin.y)//CGPoint(x: positionTexField.frame.origin.x, y:0)//positionTexField.frame.origin.y)
            for i in 0 ..< self.directoryFilterVM.positionList.count{
                list?.append((self.directoryFilterVM.positionList[i].position_name)!)
            }
            self.dropDown.dataSource = list!
            self.dropDown.show()
        case 1:
//            dropDown.bottomOffset = CGPoint(x: 0, y:countryTextField.frame.origin.y)//CGPoint(x: countryTextField.frame.origin.x,  y:0)//y:countryTextField.frame.origin.y)
            for i in 0 ..< self.directoryFilterVM.countryList.count{
                list?.append((self.directoryFilterVM.countryList[i].country_name)!)
            }
            self.dropDown.dataSource = list!
            self.dropDown.show()
        default:
//            dropDown.bottomOffset = CGPoint(x: 0, y:currentLocationTextField.frame.origin.y)//CGPoint(x: currentLocationTextField.frame.origin.x,  y:0)//y:currentLocationTextField.frame.origin.y)
            for i in 0 ..< self.directoryFilterVM.locationsList.count{
                list?.append((self.directoryFilterVM.locationsList[i].current_name)!)
            }
            self.dropDown.dataSource = list!
            self.dropDown.show()
        }
    }
}


