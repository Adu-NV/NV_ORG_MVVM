//
//  EventsViewController.swift
//  NV_ORG
//
//  Created by Netventure on 05/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit
import ExpandableCell

class EventsViewController: UIViewController{
    var price = ""
    var tag = 1
    var id = ""
    var tempId = ""
    var dictionary : Dictionary<String,String>? = Dictionary()
    var date : String = ""
    var eventModel : EventsDetailsResponeModel? = nil
    @IBOutlet weak var eventsTableView: ExpandableTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tempId = id
        getEvents()
    }
    
    func setTableView(){
        DispatchQueue.main.async {
            self.eventsTableView.expandableDelegate = self
            self.eventsTableView.animation = .automatic
            self.eventsTableView.expansionStyle = .single
            self.eventsTableView.reloadData()
        }
    }
    
    func getEvents(){
        dictionary!["event_id"] = id
        dictionary!["event_date"] = date
        Webservice.shared.EventsList(body: dictionary!) { (model, error) in
            if let _ = model{
                self.eventModel = model
            }else{
                self.eventModel = nil
            }
            self.setTableView()
        }
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
}

extension  EventsViewController : ExpandableDelegate{
    func numberOfSections(in tableView: ExpandableTableView) -> Int {
        return 1
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        return [UITableView.automaticDimension]
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if self.eventModel != nil{
            if tag == 0{
                rowCount += (self.eventModel?.data?.previous_event_list?.count)! + 2
            }else{
                rowCount += (self.eventModel?.data?.upcoming_event_list?.count)! + 2
            }
        }
        return rowCount
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        var cell1 = expandableTableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
        //        if tag == 0{
        //            cell1.venueDescriptionLabel.text = (self.eventModel?.data?.previous_event_list![indexPath.row - 2].meeting_brief)!
        //            cell1.isAttendingLabel.isHidden = true
        //            cell1.isAttendingSwitch.isHidden = true
        //             cell1.minutesButtonWidth.constant = 70
        //        }else{
        //            cell1.venueDescriptionLabel.text = (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].meeting_brief)!
        //            cell1.minutesButtonWidth.constant = 0
        //            cell1.isAttendingSwitch.isOn = (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].is_attending)!.boolValue
        //            cell1.minutesButton.isHidden = true
        //        }
        
        return [cell1]
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = NormalCell()
        
        if self.eventModel != nil{
            if indexPath.row == 0{
                cell = expandableTableView.dequeueReusableCell(withIdentifier: NormalCell.ID2) as! NormalCell
                //                cell.Clickdelegate = self
                cell.eventsNameLabel.text = (self.eventModel?.data?.current_event_details?.event_name)!
                cell.eventsDateTimeLabel.text = (self.eventModel?.data?.current_event_details?.event_date)! +  (self.eventModel?.data?.current_event_details?.event_time)!
                cell.eventsLocationLabel.text = (self.eventModel?.data?.current_event_details?.event_venue)!
                cell.eventDescriptionLabel.text = (self.eventModel?.data?.current_event_details?.event_brief)!
                if (self.eventModel?.data?.current_event_details?.event_entry_fee)! != "" || (self.eventModel?.data?.current_event_details?.event_entry_fee)! != "Free"{
                    price = "₹ \((self.eventModel?.data?.current_event_details?.event_entry_fee)!)"
                }else{
                    price = " Free "
                }
                cell.eventPriceLabel.text = price
                cell.eventEmailLabel.text = (self.eventModel?.data?.current_event_details?.event_organizer_email)!
                cell.eventPhoneLabel.text = (self.eventModel?.data?.current_event_details?.event_organizer_contact)!
                cell.eventReferenceLabel.text = (self.eventModel?.data?.current_event_details?.event_references_url)!
                cell.eventsLogoImageView.sd_setImage(with:URL(string: (self.eventModel?.data?.current_event_details?.event_organizer_picture)!)!, completed: nil)
                if self.eventModel?.data?.current_event_details?.event_picture != nil || self.eventModel?.data?.current_event_details?.event_picture! != ""{
                    cell.eventsImageViewHeight.constant = 130
                }else{
                    cell.eventsImageViewHeight.constant = 00
                }
                cell.eventsImageView.sd_setImage(with:URL(string: (self.eventModel?.data?.current_event_details?.event_picture)!)!, completed: nil)
                cell.evntsAddressLabel.text = (self.eventModel?.data?.current_event_details?.event_organizer_address)!
                cell.eventReferenceLabel.text = (self.eventModel?.data?.current_event_details?.event_references_url)!
                return cell
            }
            if indexPath.row == 1{
                cell = expandableTableView.dequeueReusableCell(withIdentifier: NormalCell.ID3) as! NormalCell
                cell.Clickdelegate = self
                return cell
            }
//            if  indexPath.row > 1 {
//                var cell1 = ExpandableCell3()
//                cell1 = expandableTableView.dequeueReusableCell(withIdentifier: ExpandableCell3.ID1) as! ExpandableCell3
//                if tag == 0{
//                    cell1.eventsTitleLabel.text = (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_name)!
//                    cell1.eventsDateLabel.text = (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_date)! +  (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_time)!
//                    cell1.eventsLocationLabel.text = (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_venue)!
//                }else{
//                    cell1.eventsTitleLabel.text = (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_name)!
//                    cell1.eventsDateLabel.text = (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_date)! +  (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_time)!
//                    cell1.eventsLocationLabel.text = (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_venue)!
//                }
//                return cell1
//            }
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

extension EventsViewController :  TableViewButtonTapped{
    func buttonTapped(sender: UIButton) {
        if sender.tag == 0{
            tag = sender.tag
        }else {
            tag = sender.tag
        }
        self.eventsTableView.reloadData()
    }
}
