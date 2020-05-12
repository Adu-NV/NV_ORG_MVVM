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
     }
     
     @IBAction func buttonPreviousTapped(_ sender: Any) {
         buttonPrevious.backgroundColor = UIColor(red: 13  / 255, green: 158 / 255, blue: 59 / 255, alpha: 1)
         buttonUpcoming.backgroundColor = UIColor(red: 170  / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
     }
     
     @IBAction func buttonUpcomingTapped(_ sender: Any) {
         buttonPrevious.backgroundColor = UIColor(red: 170  / 255, green: 170 / 255, blue: 170 / 255, alpha: 1)
         buttonUpcoming.backgroundColor = UIColor(red: 13  / 255, green: 158 / 255, blue: 59 / 255, alpha: 1)
     }
}


class ExpandableCell2: ExpandableCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
//    override func awakeFromNib() {
//    }
    static let ID = "ExpandableCell"
}



class ExpandedCell: UITableViewCell {
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
}
