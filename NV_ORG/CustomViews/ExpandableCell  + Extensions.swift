//
//  ExpandableCell  + Extensions.swift
//  NV_ORG
//
//  Created by Netventure on 12/05/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit
import ExpandableCell


class NormalCell: UITableViewCell {
    
    var Clickdelegate : TableViewButtonTapped?
    //meetings
     static let ID = "NormalCell"
     static let ID1 = "NormalCell1"
     @IBOutlet weak open var meetingsTitleLabel: UILabel!
     @IBOutlet weak open var meetingsDateLabel: UILabel!
     @IBOutlet weak open var meetingTimeLabel: UILabel!
     @IBOutlet weak open var meetingsVenueDetailsLabel: UILabel!
     @IBOutlet weak open var meetingsShortDescription: UILabel!
    @IBOutlet weak var currentMeetingsiew: UIView!
    
     @IBOutlet weak open var meetingsShowMoreButton: UIButton!
     @IBOutlet weak open var meetingsAttendingSwitch: UISwitch!
     
     @IBOutlet weak open var buttonPrevious: UIButton!
     @IBOutlet weak open var buttonUpcoming: UIButton!
     open override func awakeFromNib() {
        if let _ = currentMeetingsiew{
            currentMeetingsiew.setViewCornerRadius(radius: 6.0)
        }
         if let _ = buttonPrevious{
             buttonPrevious.layer.cornerRadius = 6.0
             buttonPrevious.layer.masksToBounds = true
             buttonUpcoming.backgroundColor =  UIColor(red: 170  / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
         }
         if let _ = buttonUpcoming{
             buttonUpcoming.layer.cornerRadius = 6.0
             buttonUpcoming.layer.masksToBounds = true
             buttonUpcoming.backgroundColor =  UIColor(red: 13  / 255, green: 158 / 255, blue: 59 / 255, alpha: 1)
         }
         if let _ = meetingsShowMoreButton{
             meetingsShowMoreButton.layer.cornerRadius = 6.0
             meetingsShowMoreButton.layer.masksToBounds = true
             meetingsShowMoreButton.backgroundColor =  UIColor(red: 13  / 255, green: 158 / 255, blue: 59 / 255, alpha: 1)
         }
        if let _ = buttonEventsPrevious{
            buttonEventsPrevious.layer.cornerRadius = 6.0
            buttonEventsPrevious.layer.masksToBounds = true
            buttonEventsUpcoming.backgroundColor =  UIColor(red: 170  / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
        }
        if let _ = buttonEventsUpcoming{
            buttonEventsUpcoming.layer.cornerRadius = 6.0
            buttonEventsUpcoming.layer.masksToBounds = true
            buttonEventsUpcoming.backgroundColor =  UIColor(red: 13  / 255, green: 158 / 255, blue: 59 / 255, alpha: 1)
        }
        if let _ = buttonRegister{
            buttonRegister.layer.cornerRadius = 6.0
            buttonRegister.layer.masksToBounds = true
            buttonRegister.backgroundColor =  UIColor(red: 13  / 255, green: 158 / 255, blue: 59 / 255, alpha: 1)
        }
        if let _  = eventsLogoImageView{
            eventsLogoImageView.setImageViewCornerRadiusWithBorder(radius: 6.0, borderwidth: 1.0, color: BUTTON_UNSELECTED_COLOR)
        }
        if let _  = eventsImageView{
            eventsImageView.setImageViewCornerRadiusWithBorder(radius: 10.0, borderwidth: 0.5, color: BUTTON_UNSELECTED_COLOR)
        }
     }
     
     @IBAction func buttonPreviousTapped(_ sender: UIButton) {
        Clickdelegate?.buttonTapped(sender: sender)
         buttonPrevious.backgroundColor = UIColor(red: 13  / 255, green: 158 / 255, blue: 59 / 255, alpha: 1)
         buttonUpcoming.backgroundColor = UIColor(red: 170  / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
     }
     
     @IBAction func buttonUpcomingTapped(_ sender: UIButton) {
        Clickdelegate?.buttonTapped(sender: sender)
         buttonPrevious.backgroundColor = UIColor(red: 170  / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
         buttonUpcoming.backgroundColor = UIColor(red: 13  / 255, green: 158 / 255, blue: 59 / 255, alpha: 1)
     }
    
    //events
    static let ID2 = "NormalCell2"
    static let ID3 = "NormalCell3"
    @IBOutlet weak var eventsLogoImageView: UIImageView!
    @IBOutlet weak var eventsNameLabel: UILabel!
    @IBOutlet weak var eventsDateTimeLabel: UILabel!
    @IBOutlet weak var eventsLocationLabel: UILabel!
    @IBOutlet weak var eventsImageView: UIImageView!
    @IBOutlet weak var eventsImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var evntsAddressLabel: UILabel!
    @IBOutlet weak var eventPriceLabel: UILabel!
    
    @IBOutlet weak var eventEmailLabel: UILabel!
    @IBOutlet weak var eventPhoneLabel: UILabel!
    @IBOutlet weak var eventReferenceLabel: UILabel!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    
    @IBAction func buttonRegister(_ sender: Any) {
    }
    @IBOutlet weak open var buttonEventsPrevious: UIButton!
    @IBOutlet weak open var buttonEventsUpcoming: UIButton!
    
    @IBAction func buttonEventsPreviousButtonTapped(_ sender: UIButton!) {
        Clickdelegate?.buttonTapped(sender: sender)
        buttonEventsPrevious.backgroundColor = UIColor(red: 13  / 255, green: 158 / 255, blue: 59 / 255, alpha: 1)
        buttonEventsUpcoming.backgroundColor = UIColor(red: 170  / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
    }
    
    @IBAction func buttonEventsUpcomingTapped(_ sender: UIButton!) {
        Clickdelegate?.buttonTapped(sender: sender)
        buttonEventsPrevious.backgroundColor = UIColor(red: 170  / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
        buttonEventsUpcoming.backgroundColor = UIColor(red: 13  / 255, green: 158 / 255, blue: 59 / 255, alpha: 1)
    }
    
}


class ExpandableCell2: ExpandableCell {
    
//    meetings
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
//    override func awakeFromNib() {
//    }
    static let ID = "ExpandableCell"
}

class ExpandableCell3 : ExpandableCell{
    //    events
    static let ID1 = "ExpandableCell1"
    @IBOutlet weak var eventsLogoImageView: UIImageView!
    @IBOutlet weak var eventsTitleLabel: UILabel!
    @IBOutlet weak var eventsDateLabel: UILabel!
    @IBOutlet weak var eventsLocationLabel: UILabel!
    override func awakeFromNib() {
        
    }
}



class ExpandedCell: UITableViewCell {
    //    meetings
    @IBOutlet weak var minutesButtonWidth: NSLayoutConstraint!
    static let ID = "ExpandedCell"
    @IBOutlet weak var venueDetailsLabel: UILabel!
    @IBOutlet weak var venueDescriptionLabel: UILabel!
    @IBOutlet weak var viewMoreButton: UIButton!
    @IBOutlet weak var isAttendingSwitch: UISwitch!
    @IBOutlet weak var isAttendingLabel: UILabel!
    @IBOutlet weak var minutesButton: UIButton!
    override func awakeFromNib() {
        if let _ = minutesButton{
            minutesButton.setCornerRadius(radius: 6.0, bg_Color: BUTTON_SELECTED_COLOR)
            
        }
        if let _ = viewMoreButton{
            viewMoreButton.setCornerRadius(radius: 6.0, bg_Color: BUTTON_SELECTED_COLOR)
        }
    }
    //    events
    static let ID1 = "ExpandedCell1"
}
