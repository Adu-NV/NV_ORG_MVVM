//
//  HomeFeedSettingsViewController.swift
//  NV_ORG
//
//  Created by Netventure on 31/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class HomeFeedSettingsViewController : UIViewController{
    let homeFeedVM = HomeFeedSettingsViewModel()
    @IBOutlet weak var homeFeedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        homeFeedVM.skipButtontapped(view: self)
    }
}

extension HomeFeedSettingsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeFeedVM.numberOfRowsInSection(section)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        homeFeedVM.numberofSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeFeedTableViewCell", for: indexPath) as! HomeFeedTableViewCell
        cell.homeFeedLabel.text = homeFeedVM.HomeAtIndex(indexPath.row).title
        cell.homeFeedSwitch.isOn = homeFeedVM.SwitchAtIndex(indexPath.row)
        return cell
    }
    
    func callApi(){
        Webservice.shared.dsashBoardRequest { (model, erroe) in
            if model != nil{
                DispatchQueue.main.async {
                    self.homeFeedVM.setdashBoardFeedModel(model: model!)
                    self.homeFeedTableView.reloadData()
                }
             }
        }
    }
}
