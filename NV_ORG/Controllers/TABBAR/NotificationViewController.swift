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
    var not_Model : NotificationListResponseModel? = nil
    var rowCount = 0
    
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
        self.setUP()
    }
    
    func setUI(){
        self.notificationsTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
        self.anouncementButton.titleLabel?.textColor = (tag == 0 ? .black : .blue)
        self.notificationsButton.titleLabel?.textColor = (tag == 0 ? .blue : .black)
        self.anouncementView.backgroundColor = (tag == 0 ? .white : .gray)
        self.notificationsView.backgroundColor = (tag == 0 ? .gray : .white)
    }
    
    @IBAction func anouncementButtonTapped(_ sender: Any) {
        tag = 1
        self.setUP()
    }
    
    @IBAction func notificationButtonTapped(_ sender: Any) {
        tag = 0
        self.setUP()
    }
    
    func setUP(){
        self.getList()
        self.setUI()
    }
    
    func getList(){
        
        Webservice.shared.getNotificationList(tag: tag) { (model, error) in
            if let _ = model{
                self.not_Model = model
                self.rowCount = (self.tag == 0 ? (self.not_Model?.data?.notifications_list != nil ? (model?.data!.notifications_list!.count)! : 0) :  ((self.not_Model?.data?.announcement_list != nil ? (model?.data!.announcement_list!.count)! : 0)))
                self.notificationsVM.numberofRows = self.rowCount
                DispatchQueue.main.async {
                    self.notificationsTableView.reloadData()
                }
            }
        }
    }
}


extension NotificationViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        notificationsVM.numberofSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationsVM.numberOfRowsInSection(section, tag) == 0 ? 1 : notificationsVM.numberOfRowsInSection(section, tag)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if notificationsVM.numberofRows == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
//            cell.noDataImageView.image = UIImage(named: "nodatafound.png")
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "No Data Available"
            return cell
        }
        if tag == 0{
           let cell1 = tableView.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell", for: indexPath) as! NotificationsTableViewCell
            cell1.notificationTitleLabel.text = (self.not_Model?.data?.notifications_list![indexPath.row].notification_brief)!
            return cell1
        }else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "AnouncementsTableViewCell", for: indexPath) as! AnouncementsTableViewCell
            cell2.anouncementsTitleLabel.text = (self.not_Model?.data?.announcement_list![indexPath.row].announcement_brief)!
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if notificationsVM.numberofRows == 0{
            return tableView.frame.height
        }else{
            return notificationsVM.heightForRow(indexPath.row)
        }
    }
}
