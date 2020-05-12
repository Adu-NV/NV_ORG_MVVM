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
    var activitiIndicatorView = UIView()
    var meetingsDetailModel : MeetingsDetailsResponseModel? = nil
    @IBOutlet weak var mingsTableView: ExpandableTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getMeetings(id: id)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if #available(iOS 13.0, *) {
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }else{
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func getMeetings(id: String){
        activitiIndicatorView = self.showActivityIndicator(_message: "Please wait...")
        Webservice.shared.getMeetingsDetails(id: id) { (model, error) in
            self.hideActivityIndicator(uiView: self.activitiIndicatorView)
            if let _ = model{
                self.meetingsDetailModel = model
            }else{
                self.meetingsDetailModel = nil
            }
            self.setUI()
        }
    }
    
    func setUI(){
        DispatchQueue.main.async {
            self.mingsTableView.expandableDelegate = self
//            self.mingsTableView.dataSource = self
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
        var cell1 = expandableTableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
        if tag == 0{
            cell1.venueDescriptionLabel.text = (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_brief)!
            cell1.isAttendingLabel.isHidden = true
            cell1.isAttendingSwitch.isHidden = true
             cell1.minutesButtonWidth.constant = 70
        }else{
            cell1.venueDescriptionLabel.text = (self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].meeting_brief)!
            cell1.minutesButtonWidth.constant = 0
            cell1.minutesButton.isHidden = true
        }
        
        return [cell1]
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
                cell.meetingsDateLabel.text = (self.meetingsDetailModel?.data?.current_meeting?.meeting_date)!
                cell.meetingTimeLabel.text = (self.meetingsDetailModel?.data?.current_meeting?.meeting_time)!
                cell.meetingsShortDescription.text = (self.meetingsDetailModel?.data?.current_meeting?.meeting_brief)!
//                cell.meetingsAttendingSwitch.isOn = (self.meetingsDetailModel?.data?.current_meeting?.is_attending! as! Bool)
                return cell
            }
            if indexPath.row == 1{
                cell = expandableTableView.dequeueReusableCell(withIdentifier: NormalCell.ID1) as! NormalCell
                 return cell
            }
            if  indexPath.row > 1 {
                var cell = ExpandableCell2()
                cell = expandableTableView.dequeueReusableCell(withIdentifier: ExpandableCell2.ID) as! ExpandableCell2
                if tag == 0{
                    cell.titleLabel.text = (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_name)!
                    cell.dateLabel.text = (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_date)!
                    cell.timeLabel.text = (self.meetingsDetailModel?.data?.previous_meeting_list![indexPath.row - 2].meeting_time)!
                }else{
                    cell.titleLabel.text = (self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].meeting_name)!
                    cell.dateLabel.text = (self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].meeting_date)!
                    cell.timeLabel.text = (self.meetingsDetailModel?.data?.upcoming_meeting_list![indexPath.row - 2].meeting_time)!
                }
                return cell
            }
        }else{
            return UITableViewCell()
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

