//
//  UICollectionViewCells.swift
//  NV_ORG
//
//  Created by Netventure on 08/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

class DashBoardCollectionViewCell : UICollectionViewCell{
    // cell 1
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    
    // cell 2
    @IBOutlet weak var eventsImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventOrganiserLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    // cell 3
    @IBOutlet weak var meetingNameLabel: UILabel!
    @IBOutlet weak var meetingDateLabel: UILabel!
    @IBOutlet weak var meetingTimeLabel: UILabel!
    @IBOutlet weak var meetingDetailsbButton: UIButton!
    
    // cell 4
    @IBOutlet weak var wishesNameLabel: UILabel!
    @IBOutlet weak var wishesTitleLabel: UILabel!
    @IBOutlet weak var wishesImageView: UIImageView!
    @IBOutlet weak var wishesCallbButton: UIButton!
    @IBOutlet weak var wishesChatbButton: UIButton!
    
//    cell 5:
    @IBOutlet weak var galleryImageView: UIImageView!
    override func awakeFromNib() {
        
        if let _ = meetingDetailsbButton{
            self.meetingDetailsbButton.setCornerRadiusWithoutBackground(radius: 8.0)
        }
        if let _ = meetingNameLabel{
            self.contentView.setViewCornerRadiusWithBorder(radius: 10.0, borderColor: .black, width: 0.5)
        }
        if let _ = wishesChatbButton{
            self.contentView.setViewCornerRadiusWithBorder(radius: 10.0, borderColor: .black, width: 0.5)
            wishesChatbButton.setCornerRadiusWithoutBackground(radius: 8.0)
        }
        if let _ = wishesCallbButton{
            wishesCallbButton.setCornerRadiusWithoutBackground(radius: 8.0)
        }
        if let _ = wishesImageView{
            wishesImageView.setImageViewCornerRadius(radius: 10.0)
        }
        if let _ = eventsImageView{
            eventsImageView.setImageViewCornerRadius(radius: 10.0)
        }
        if let _ = newsImageView{
            newsImageView.setImageViewCornerRadius(radius: 10.0)
        }
    }
}
