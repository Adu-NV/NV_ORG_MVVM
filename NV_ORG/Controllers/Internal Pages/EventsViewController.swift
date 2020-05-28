//
//  EventsViewController.swift
//  NV_ORG
//
//  Created by Netventure on 05/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import UIKit
import ExpandableCell
import FSCalendar

class EventsViewController: UIViewController{
    var dates : [String] = [String]()
    var formatter = DateFormatter()
    var calender1: FSCalendar!
    var fsCalenderView: UIView!
    var dateString = ""
    var row = 0
    var price = ""
    var tag = 1
    var id = ""
    var tempId = ""
    var dictionary : Dictionary<String,String>? = Dictionary()
    var date : String = ""
    var expanded : [Bool] = []
    var eventModel : EventsDetailsResponeModel? = nil
    var activitiIndicatorView = UIView()
    @IBOutlet weak var eventsTableView: ExpandableTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tempId = id
        DispatchQueue.main.async {
            self.eventsTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
        }
        getEvents()
    }
    
    func setTableView(){
        self.expanded.removeAll()
        DispatchQueue.main.async {
            self.eventsTableView.expandableDelegate = self
            self.eventsTableView.animation = .automatic
            self.eventsTableView.expansionStyle = .single
            self.setExpanded()
        }
    }
    
    func getEvents(){
        row = 0
        dictionary!["event_id"] = id
        dictionary!["event_date"] = date
        Webservice.shared.EventsList(body: dictionary!) { (model, error) in
            if let _ = model{
                self.eventModel = model
                if (self.eventModel?.data?.upcoming_event_list?.isEmpty)! && (self.eventModel?.data?.previous_event_list?.isEmpty)!{
                    self.row = 0
                }else{
                    self.row = 1
                }
            }else{
                self.eventModel = nil
            }
            self.setTableView()
        }
    }
    
    @IBAction func calenderButtonTapped(_ sender: Any) {
        getEventDates()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
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
                rowCount += (self.eventModel?.data?.previous_event_list?.count)! + self.row + 1
            }else{
                rowCount += (self.eventModel?.data?.upcoming_event_list?.count)! + self.row + 1
            }
        }else{
            rowCount = 1
        }
        return rowCount
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        return nil
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let _ = self.eventModel{
            if indexPath.row > 1 && !self.expanded[indexPath.row - 1]{
                return UITableView.automaticDimension//150
            }else{
                return UITableView.automaticDimension
            }
        }else{
            return eventsTableView.frame.height
        }

    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = NormalCell()
        if self.eventModel != nil{
            if indexPath.row == 0{
                cell = expandableTableView.dequeueReusableCell(withIdentifier: NormalCell.ID2) as! NormalCell
                cell.eventsNameLabel.text = (self.eventModel?.data?.current_event_details?.event_name)!
                cell.eventsDateTimeLabel.text = "\((self.eventModel?.data?.current_event_details?.event_date)!.setTime(format: "dd MMM YYYY"))  " +  (self.eventModel?.data?.current_event_details?.event_time)!
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
                if (self.eventModel?.data?.current_event_details?.event_register_url) != nil{
                    cell.buttonRegister.isHidden = true
                    cell.buttonRegister.isEnabled = true
                    cell.buttonRegister.addTarget(self, action: #selector(callURL), for: .touchUpInside)
                }else{
                    cell.buttonRegister.isHidden = true
                    cell.buttonRegister.isEnabled = false
                    cell.buttonRegister.backgroundColor = BUTTON_UNSELECTED_COLOR
                }
                return cell
            }
            if indexPath.row == 1{
                cell = expandableTableView.dequeueReusableCell(withIdentifier: NormalCell.ID3) as! NormalCell
                cell.Clickdelegate = self
                return cell
            }
            if  indexPath.row > 1 {
                cell = expandableTableView.dequeueReusableCell(withIdentifier: NormalCell.ID4) as! NormalCell
                cell.eventsNameLabel.text = (tag == 0 ?(self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_name)! : (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_name)!)
                cell.eventsDateTimeLabel.text = (tag == 0 ? "\((self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_date)!.setTime(format: "dd MMM YYYY") +  (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_time)!)" :  "\((self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_date)!.setTime(format: "dd MMM YYYY") +  (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_time)!)")
                cell.eventsLocationLabel.text =  (tag == 0 ? (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_venue)! : (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_venue)!)
                cell.eventsLogoImageView.sd_setImage(with:URL(string: (tag == 0 ? (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_organizer_picture)! : (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_organizer_picture)!))!, completed: nil)
                cell.touchDelegate = self
                cell.buttonArrow.tag = indexPath.row
                if expanded[indexPath.row - 1]{
                    cell.eventsImageViewHeight.constant = 130
                    cell.addressPriceStackHeight.constant = 70
                    cell.contactStackViewHeight.constant = 80
                    cell.registerButtonHeight.constant = 30
                    cell.buttonRegister.isHidden = true
                     cell.eventDescriptionLabel.isHidden = false
                    cell.buttonArrow.setImage(UIImage(named: "up.png"), for: .normal)
                    cell.eventDescriptionLabel.text =  (tag == 0 ?(self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_brief)! : (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_brief)!)
                    cell.eventEmailLabel.text = (tag == 0 ? (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_organizer_email)! : (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_organizer_email)!)
                    cell.eventPhoneLabel.text =  (tag == 0 ? (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_organizer_contact)! : (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_organizer_contact)!)
                    cell.eventReferenceLabel.text =  (tag == 0 ? (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_references_url)! : (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_references_url)!)
                    cell.evntsAddressLabel.text =  (tag == 0 ? (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_organizer_address)! : (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_organizer_address)!)
                    cell.eventsImageView.sd_setImage(with:URL(string: (tag == 0 ? (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_picture)! : (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_picture)!))!, completed: nil)
                    
                    if (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_entry_fee)! != "" || (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_entry_fee)! != "Free" && tag == 0{
                        price = "₹ \((self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_entry_fee)!)"
                    }else if (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_entry_fee)! != "" || (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_entry_fee)! != "Free" && tag == 1{
                        price = "₹ \((self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_entry_fee)!)"
                    }else{
                        price = " Free "
                    }
                    cell.eventPriceLabel.text = price
                    if (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_picture)! != "" || (self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_picture)! != nil && tag == 0{
                         cell.eventsImageViewHeight.constant = 130
                    }else  if (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_picture)! != "" || (self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_picture)! != nil && tag == 1{
                        cell.eventsImageViewHeight.constant = 130
                    }else{
                        cell.eventsImageViewHeight.constant = 0
                    }
                    if let _ = (tag == 0 ? self.eventModel?.data?.previous_event_list![indexPath.row - 2].event_register_url : self.eventModel?.data?.upcoming_event_list![indexPath.row - 2].event_register_url){
                        cell.buttonRegister.isEnabled = true
                    }else{
                        cell.buttonRegister.isEnabled = false
                        cell.buttonRegister.backgroundColor = BUTTON_UNSELECTED_COLOR
                    }
                     return cell
                }else{
                     cell.buttonArrow.setImage(UIImage(named: "down.png"), for: .normal)
                    cell.expandedViewHeightConstraint.constant = 0
                    cell.eventsImageViewHeight.constant = 0
                    cell.addressPriceStackHeight.constant = 0
                    cell.contactStackViewHeight.constant = 0
                    cell.registerButtonHeight.constant = 0
                    cell.eventDecriptiionHeight.constant = 0
                    cell.eventDescriptionLabel.isHidden = true
                    cell.eventDescriptionLabel.text = ""
                    return cell
                }
            }else{
                return UITableViewCell()
            }
        }else{
            let cell = expandableTableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "No Data Found...!"
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func tableViewCellInsideTapped(row : NormalCell){
        print("didSelectRow:\(row)")
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
        if let cell = expandedCell as? ExpandedCell {
            print("\(cell.venueDescriptionLabel.text ?? "")")
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectExpandedRowAt indexPath: IndexPath) {
        print("didSelectRow:\(indexPath)")
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRow:\(indexPath)")
    }

        
    @objc func callURL(){
        let urlPage = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "URLViewController") as! URLViewController
        urlPage.urlString = (self.eventModel?.data?.current_event_details?.event_register_url)!
        if #available(iOS 13.0, *) {
            urlPage.modalPresentationStyle = .fullScreen
            self.present(urlPage, animated: true)
        }else{
            self.present(urlPage, animated: false, completion: nil)
        }
    }
}

extension EventsViewController :  TableViewButtonTapped,TableViewTouchDelegate{
    func touchInitiated(row: Int) {
        self.expanded[row - 1] =  !self.expanded[row - 1]
        DispatchQueue.main.async {
            self.eventsTableView.reloadData()
        }
    }
    
    func buttonTapped(sender: UIButton) {
        self.expanded.removeAll()
        if sender.tag == 0{
            tag = sender.tag
        }else {
            tag = sender.tag
        }
        self.setExpanded()
    }
    
    func setExpanded(){
        if let _ = self.eventModel?.data?.current_event_details{
            self.expanded.append(true)
        }
        if tag == 0 {
            if let _ = self.eventModel?.data?.previous_event_list, !(self.eventModel?.data?.previous_event_list!.isEmpty)!{
                for i in 0 ..< (self.eventModel?.data?.previous_event_list!.count)!{
                    self.expanded.append(false)
                }
            }
        }else{
            if let _ = self.eventModel?.data?.upcoming_event_list, !(self.eventModel?.data?.upcoming_event_list!.isEmpty)!{
                for i in 0 ..< (self.eventModel?.data?.upcoming_event_list!.count)!{
                    self.expanded.append(false)
                }
            }
        }
        DispatchQueue.main.async {
            self.eventsTableView.reloadData()
        }
    }
}

extension EventsViewController : FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance{
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.fsCalenderView.removeFromSuperview()
    }
    
    func getEventDates(){
        self.dates.removeAll()
        activitiIndicatorView = self.showActivityIndicator(_message: "Please wait...")
        Webservice.shared.getEventsDates { (model, error) in
            self.hideActivityIndicator(uiView: self.activitiIndicatorView)
            if let _ = model{
                if !(model?.data?.event_list!.isEmpty)!{
                    for i in 0 ..< (model?.data?.event_list!.count)!{
                        self.dates.append((model?.data?.event_list![i].event_date)!.setTime(format: "yyyy-MM-dd"))
                    }
                }
                DispatchQueue.main.async {
                    self.view.addSubview(self.setCalenderUI())
                    self.setFsCalenderDates()
                }
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        var dateStr = self.formatter.string(from: date)
        dateString = dateStr
        self.date = dateString
        id = ""
        getEvents()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.formatter.string(from: date)
        if self.dates.contains(dateString) {
            return 1
        }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        let dateString = self.formatter.string(from: date)
        if self.dates.contains(dateString) {
            return 6.0
               }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
                let dateString = self.formatter.string(from: date)
        if self.dates.contains(dateString) {
            return [.blue]
        }
        return [.white]
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
         let dateString = self.formatter.string(from: date)
        if self.dates.contains(dateString) {
            return [.green]
        }
        return [.blue]
    }
    
    func setFsCalenderDates(){
        formatter.dateFormat = "yyyy-MM-dd"
    }
    
    func setCalenderUI() -> UIView{

        self.fsCalenderView = UIView(frame: CGRect(x: self.view.frame.width - 240, y: 70, width: 240, height: 220))
        self.fsCalenderView.setViewCornerRadiusWithBorder(radius: 6.0, borderColor: BUTTON_LIGHT_GREEN_COLOR, width: 0.5)
        self.calender1 = FSCalendar(frame: CGRect(x:10, y: 30, width: 220, height: 190))
        let buttonClose = UIButton(frame: CGRect(x: self.fsCalenderView.frame.width - 25, y: 5, width: 20, height: 20))
        buttonClose.setImage(UIImage(named: "close.png"), for: .normal)
        buttonClose.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        self.fsCalenderView.backgroundColor = BUTTON_UNSELECTED_COLOR
        self.calender1.delegate = self
        self.calender1.dataSource = self
        self.calender1.scope = .month
        self.calender1.placeholderType = .none
        self.calender1.allowsSelection = true
        self.fsCalenderView.addSubview(self.calender1)
        self.fsCalenderView.addSubview(buttonClose)
        return self.fsCalenderView
    }
}
