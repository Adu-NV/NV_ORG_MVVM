//
//  NotificationViewController.swift
//  NV_ORG
//
//  Created by Netventure on 28/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    let notificationsVM = NotificationsViewModel()
    var tag = 0
    
    @IBOutlet weak var notificationsTableView: UITableView!
    @IBOutlet weak var anouncementView: UIView!
    @IBOutlet weak var anouncementButton: UIButton!
    @IBOutlet weak var notificationsView: UIView!
    @IBOutlet weak var notificationsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tag = 0
        setUI()
    }
    
    func setUI(){
        self.anouncementButton.titleLabel?.textColor = (tag == 0 ? .black : .blue)
        self.notificationsButton.titleLabel?.textColor = (tag == 0 ? .blue : .black)
        self.anouncementView.backgroundColor = (tag == 0 ? .white : .gray)
        self.notificationsView.backgroundColor = (tag == 0 ? .gray : .white)
        self.notificationsTableView.reloadData()
    }
    
    @IBAction func anouncementButtonTapped(_ sender: Any) {
        tag = 1
        setUI()
    }
    
    @IBAction func notificationButtonTapped(_ sender: Any) {
        tag = 0
       setUI()
    }
}


extension NotificationViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        notificationsVM.numberofSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notificationsVM.numberOfRowsInSection(section, tag)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tag == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell", for: indexPath) as! NotificationsTableViewCell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "AnouncementsTableViewCell", for: indexPath) as! AnouncementsTableViewCell
        }
        return cell
    }
}
