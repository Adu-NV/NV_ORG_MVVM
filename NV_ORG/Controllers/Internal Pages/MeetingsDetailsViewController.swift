//
//  MeetingsDetailsViewController.swift
//  NV_ORG
//
//  Created by Netventure on 11/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit
import ExpandableCell

class MeetingsDetailsViewController: UIViewController {
    var id  =  ""
    var tag = 1
    var meeting_id = ""
    var isAttending = false
    var activitiIndicatorView = UIView()
    var meetingsDetailModel : MeetingsDetailsResponseModel? = nil
    var temp_MeetingsModel : MeetingsDetailsResponseModel? = nil
    @IBOutlet weak var mingsTableView: ExpandableTableView!
    
    override func viewDidLoad() {
        self.mingsTableView.tableFooterView = UIView()
         self.mingsTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getMeetings(id: id)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func getMeetings(id: String){
        activitiIndicatorView = self.showActivityIndicator(_message: "Please wait...")
        Webservice.shared.getMeetingsDetails(id: id) { (model, error) in
            self.hideActivityIndicator(uiView: self.activitiIndicatorView)
            if let _ = model{
                self.meetingsDetailModel = model
                self.temp_MeetingsModel = self.meetingsDetailModel
            }else{
                self.meetingsDetailModel = nil
            }
            self.setUI()
        }
    }
    
    func setUI(){
        DispatchQueue.main.async {
            self.mingsTableView.expandableDelegate = self
            self.mingsTableView.animation = .automatic
            self.mingsTableView.expansionStyle = .single
            self.mingsTableView.reloadData()
        }
    }
}

extension  MeetingsDetailsViewController : ExpandableDelegate{
    func numberOfSections(in tableView: ExpandableTableView) -> Int {
        return 1
    }
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func expandableTableView(_ expandableTableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        return [UITableView.automaticDimension]
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if self.meetingsDetailModel != nil{
            if tag == 0{
                rowCount += (self.meetingsDetailModel?.data?.previous_meeting_list?.count)! + 2
            }else{
                rowCount += (self.meetingsDetailModel?.data?.upcoming_meeting_list?.count)! + 2
            }
        }
        return rowCount
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        if indexPath.row > 1{
            var cell1 = expandableTableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
            if tag == 0{
                if indexPath.row - 2 < (self.meetingsDetailModel?.data?.previous_meeting_list!.count)! && indexPath.row >= 2{
                    let address = (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_address) != nil ? (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_address)! : ""
                    let state = (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_state) != nil ? (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_state)! : ""
                    let country = (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_country) != nil ? (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_country)! : ""
                    
                    cell1.venueDetailsLabel.text = "\(address) \(address != "" ? "\n" : "")\(state) \(state != "" ? "\n" : "")\(country) \(country != "" ? "\n" : "")"
                    cell1.venueDescriptionLabel.text = (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_brief)!
                    cell1.isAttendingLabel.isHidden = true
                    cell1.isAttendingSwitch.isHidden = true
                    cell1.minutesButtonWidth.constant = 70
                    cell1.viewMoreButton.tag = indexPath.row
                    cell1.viewMoreButton.addTarget(self, action: #selector(buttonViewMoreButtonTapped(sender:)), for: .touchUpInside)
                }
            }else{
                if indexPath.row - 2 < (self.meetingsDetailModel?.data?.upcoming_meeting_list!.count)! && indexPath.row >= 2{
                    cell1.venueDetailsLabel.text = "\((self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].meeting_address)!) \n\((self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].meeting_state)!) \n\((self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].meeting_country)!)"
                    cell1.venueDescriptionLabel.text = (self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].meeting_brief)!
                    cell1.minutesButtonWidth.constant = 0
                    cell1.isAttendingSwitch.isOn = (self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].is_attending)!.boolValue
                    cell1.isAttendingSwitch.tag = indexPath.row
                    cell1.isAttendingLabel.isHidden = true
                    cell1.isAttendingSwitch.isHidden = true
                    cell1.minutesButton.isHidden = true
                    cell1.viewMoreButton.tag = indexPath.row
                    cell1.viewMoreButton.addTarget(self, action: #selector(buttonViewMoreButtonTapped(sender:)), for: .touchUpInside)
                }
            }
            return [cell1]
        }else{
            return nil
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = NormalCell()
        if self.meetingsDetailModel != nil{
            if indexPath.row == 0{
                cell = expandableTableView.dequeueReusableCell(withIdentifier: NormalCell.ID) as! NormalCell
                cell.meetingsTitleLabel.text = (self.meetingsDetailModel?.data?.current_meeting?.meeting_name)!
                cell.meetingsVenueDetailsLabel.text = "\((self.meetingsDetailModel?.data?.current_meeting?.meeting_address)!) \n\((self.meetingsDetailModel?.data?.current_meeting?.meeting_state)!) \n\((self.meetingsDetailModel?.data?.current_meeting?.meeting_country)!)"
                cell.meetingsDateLabel.text = (self.meetingsDetailModel?.data?.current_meeting?.meeting_date)!.setTime(format: "dd MMM YYYY")
                cell.meetingTimeLabel.text = (self.meetingsDetailModel?.data?.current_meeting?.meeting_time)!
                cell.meetingsShortDescription.text = (self.meetingsDetailModel?.data?.current_meeting?.meeting_brief)!
                cell.meetingsAttendingSwitch.isOn = (self.meetingsDetailModel?.data?.current_meeting?.is_attending)!.boolValue
                cell.meetingsAttendingSwitch.addTarget(self, action: #selector(meetingAttendingSwitch(sender:)), for: .touchUpInside)
                cell.meetingsShowMoreButton.tag = indexPath.row
                cell.meetingsAttendingSwitch.tag = indexPath.row
                cell.meetingsShowMoreButton.addTarget(self, action: #selector(buttonViewMoreButtonTapped(sender:)), for: .touchUpInside)
                return cell
            }
            if indexPath.row == 1{
                cell = expandableTableView.dequeueReusableCell(withIdentifier: NormalCell.ID1) as! NormalCell
                cell.Clickdelegate = self
                return cell
            }
            if  indexPath.row > 1 {
                if tag == 0{
                    if (self.meetingsDetailModel?.data?.previous_meeting_list!.count)! == 0{
                        let cell = expandableTableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
                        cell.textLabel?.textAlignment = .center
                        cell.textLabel?.text = "No Data Available"
                        return cell
                    }else{
                        if indexPath.row - 2 < (self.meetingsDetailModel?.data?.previous_meeting_list!.count)!{
                            let cell = expandableTableView.dequeueReusableCell(withIdentifier: ExpandableCell.ID) as! ExpandableCell
                            cell.titleLabel.text = (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_name)!
                            cell.dateLabel.text = (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_date)!.setTime(format: "dd MMM YYYY")
                            cell.timeLabel.text = (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_time)!
                            return cell
                        }
                    }
                }else{
                    if (self.meetingsDetailModel?.data?.previous_meeting_list!.count)! == 0{
                        let cell = expandableTableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
                        cell.textLabel?.textAlignment = .center
                        cell.textLabel?.text = "No Data Available"
                        return cell
                    }else{
                        if indexPath.row - 2 < (self.meetingsDetailModel?.data?.upcoming_meeting_list!.count)!{
                            let cell = expandableTableView.dequeueReusableCell(withIdentifier: ExpandableCell.ID) as! ExpandableCell
                            cell.titleLabel.text = (self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].meeting_name)!
                            cell.dateLabel.text = (self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].meeting_date)!.setTime(format: "dd MMM YYYY")
                            cell.timeLabel.text = (self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].meeting_time)!
                            return cell
                        }
                    }
                }
            }
        }else{
            let cell = expandableTableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "No Data Available"
            return cell
        }
        return UITableViewCell()
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
        if let cell = expandedCell as? ExpandedCell {
            print("\(cell.venueDescriptionLabel.text ?? "")")
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRow:\(indexPath)")
    }
}

extension MeetingsDetailsViewController:  TableViewButtonTapped{
    @objc func meetingAttendingSwitch(sender : UISwitch){
        if sender.tag == 0 {
            isAttending = sender.isOn
            meeting_id = (self.meetingsDetailModel?.data?.current_meeting?.meeting_id)!
        }else{
            isAttending = sender.isOn
            meeting_id = (self.meetingsDetailModel?.data?.upcoming_meeting_list![sender.tag - 2].meeting_id)!
        }
        callAttendingAPI(attending: isAttending, id: meeting_id)
    }
    
    func callAttendingAPI(attending:  Bool,id : String){
        self.showAlert(ATTENDING_CONFIRMATION) { (suucess) in
            if suucess{
                var dic = Dictionary<String,Any>()
                dic["is_attending"] = self.isAttending
                dic["meeting_id"]  = id
                Webservice.shared.isAttending(body: dic) { (model, error) in
                    if let _model = model{
                        if _model.message == SUCCESS{
                            self.setUI()
                        }else{
                            self.setUI()
                        }
                    }
                }
            }else{
                return
            }
        }
    }
    
    func showAlert(_ message:String,CompletionBlock:@escaping(Bool)-> Void){
        let alertController = UIAlertController()
        if #available(iOS 13, *){
            self.addChild(alertController)
        }
        alertController.simpAlert(title: APPLICATION_NAME, message: message, isOkButton: true, isCancelButton: true, okButtonText: YES_TEXT, cancelbuttonText: NO_TEXT, preferredStyle: .alert) { (success, failure) in
            if success{
                CompletionBlock(true)
            }else{
                CompletionBlock(false)
            }
        }
    }
    
    func buttonTapped(sender: UIButton) {
        if sender.tag == 0{
            tag = sender.tag
        }else {
            tag = sender.tag
        }
        self.getMeetings(id: id)
//        self.meetingsDetailModel = self.temp_MeetingsModel
//        self.mingsTableView.reloadData()
    }
    
    @objc func buttonViewMoreButtonTapped(sender:UIButton){
        debugPrint("sender")
        let alertController = UIAlertController()
        if #available(iOS 13, *){
            self.addChild(alertController)
        }
        alertController.simpAlert(title: APPLICATION_NAME, message: "Page Under Development", isOkButton: true, isCancelButton: false, okButtonText: OK_TEXT, cancelbuttonText: nil, preferredStyle: .alert) { (success, failure) in
            if success{
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
