//
//  LeaderShipViewController.swift
//  NV_ORG
//
//  Created by Netventure on 31/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class LeaderShipViewController: UIViewController {
    let leadershipVM = LeaderShipViewModel()
    @IBOutlet weak var leadershipTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        leadershipVM.skipButtontapped(view: self)
    }

}

extension LeaderShipViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           leadershipVM.numberOfRowsInSection(section)
       }
       func numberOfSections(in tableView: UITableView) -> Int {
           leadershipVM.numberofSections
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderShipTableViewCell", for: indexPath) as! LeaderShipTableViewCell
//           cell.notificationLabel.text = notificationSettingsVM.NotificationAtIndex(indexPath.row)
           return cell
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        leadershipVM.heightForRow(indexPath.row)
    }
}
