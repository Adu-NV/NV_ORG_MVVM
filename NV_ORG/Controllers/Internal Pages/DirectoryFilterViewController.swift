//
//  DirectoryFilterViewController.swift
//  NV_ORG
//
//  Created by Netventure on 29/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class DirectoryFilterViewController: UIViewController {
    var directoryFilterVM = DirectoryFilterViewModel()
    @IBOutlet weak var filterApplyButton: UIButton!
    
    @IBOutlet weak var filterCloseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        filterApplyButton.setCornerRadius(radius: 10.0, bg_Color: BUTTON_LOGIN_COLOR)
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpUI()
    }
    
    func setUpUI(){
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
