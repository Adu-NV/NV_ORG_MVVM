//
//  NotificationSettingsViewController.swift
//  NV_ORG
//
//  Created by Netventure on 31/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class NotificationSettingsViewController: UIViewController {
    
    let notificationSettingsVM = NotificationSettingsViewModel()
    @IBOutlet weak var notificationSettingsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationSettingsTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        notificationSettingsVM.skipButtontapped(view: self)
    }
}

extension NotificationSettingsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notificationSettingsVM.numberOfRowsInSection(section)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        notificationSettingsVM.numberofSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        cell.notificationLabel.text = notificationSettingsVM.NotificationAtIndex(indexPath.row)
        return cell
    }
}

