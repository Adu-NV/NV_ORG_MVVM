//
//  UITableViews.swift
//  NV_ORG
//
//  Created by Netventure on 28/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit
class MenuTableViewCells : UITableViewCell{
    @IBOutlet weak var buttonProfile: UIButton!
    @IBOutlet weak var namLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    override func awakeFromNib() {
        if let _ = buttonProfile{
            buttonProfile.setCornerRadius(radius: self.buttonProfile.frame.height
                / 2, bg_Color: .clear)
        }
    }
}

class AboutTableViewCell : UITableViewCell{
    @IBOutlet weak var aboutLabel: UILabel!
    override func awakeFromNib() {
        
    }
}

class PrivacyTableViewCell : UITableViewCell{
    @IBOutlet weak var privacyLabel: UILabel!
    override func awakeFromNib() {
    }
}

class HomeFeedTableViewCell : UITableViewCell{
    @IBOutlet weak var homeFeedSwitch: UISwitch!
    @IBOutlet weak var homeFeedLabel: UILabel!
    override func awakeFromNib() {
    }
}

class NotificationTableViewCell : UITableViewCell{
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var notificationLabel: UILabel!
    override func awakeFromNib() {
    }
}


class LeaderShipTableViewCell : UITableViewCell{
    @IBOutlet weak var leaderShipImageView: UIImageView!
    @IBOutlet weak var leaderShipPositionLabel: UILabel!
    @IBOutlet weak var leaderShipNameLabel: UILabel!
    override func awakeFromNib() {
        if let _ = leaderShipImageView{
            leaderShipImageView.layer.cornerRadius =  leaderShipImageView.frame.height / 2
            leaderShipImageView.layer.masksToBounds = true
        }
    }
}
    //MARK:- ProfileTableViewCell
class profileTableViewCell : UITableViewCell{

    //profileCoverView
    @IBOutlet weak var profileCoverView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var userPositionLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var userMobileNumberLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userSocietyLabel: UILabel!
    @IBOutlet weak var userJoiningLabel: UILabel!
    @IBOutlet weak var userTeamLabel: UILabel!
    
    //MARK:- ProfileTableViewCell1
    
    @IBOutlet weak var userAddressLabel: UILabel!
    @IBOutlet weak var userEducationLabel: UILabel!
    @IBOutlet weak var userJobExperienceLabel: UILabel!
    @IBOutlet weak var userCareerlabel: UILabel!
    @IBOutlet weak var userMartialLabel: UILabel!
    @IBOutlet weak var userSpouseLabel: UILabel!
    @IBOutlet weak var usersLocationLabel: UILabel!
    @IBOutlet weak var userCountryLabel: UILabel!
    @IBOutlet weak var userPlaceInKeralaLabel: UILabel!
    @IBOutlet weak var userBuddyLabel: UILabel!
    @IBOutlet weak var dateofPlannedLabel: UILabel!
    
    override func awakeFromNib() {
        if let _ = profileImageView{
            profileImageView.layer.cornerRadius = 16.0
            profileImageView.layer.masksToBounds = true
            profileImageView.layer.borderWidth = 2.0
            profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        }
        if let _ = profileCoverView{
            profileCoverView.layer.cornerRadius = 16.0
            profileCoverView.layer.masksToBounds = true
            profileCoverView.layer.borderWidth = 1.0
            profileCoverView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}

    //MARK:- DirectoryTableViewCell

class DirectoryTableViewCell : UITableViewCell{
    @IBOutlet weak var directoryProfileImageView: UIImageView!
    @IBOutlet weak var directoryNameLabel: UILabel!
    @IBOutlet weak var directorypositionLabel: UILabel!
    @IBOutlet weak var directoryMobileLabel: UILabel!
    @IBOutlet weak var directoryChat: UIButton!
    override func awakeFromNib() {
        if let _ =  directoryProfileImageView{
            directoryProfileImageView.layer.cornerRadius = 21
            directoryProfileImageView.layer.masksToBounds = true
        }
    }
}

class NotificationsTableViewCell : UITableViewCell{
    @IBOutlet weak var notificationTitleLabel: UILabel!
    override func awakeFromNib() {
        
    }
}

class AnouncementsTableViewCell : UITableViewCell{
    @IBOutlet weak var anouncementsTitleLabel: UILabel!
    override func awakeFromNib() {
        
    }
}

class ProfileEditTableViewCell : UITableViewCell{
    override func awakeFromNib() {
        
    }
}


class DashBoardTableViewCell : UITableViewCell{
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var meetingsCollectionView: UICollectionView!
    @IBOutlet weak var WishesCollectionView: UICollectionView!
    var layout : UICollectionViewDelegateFlowLayout!
    
//    cell 0
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    //    cell 4
    
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobExperienceLabel: UILabel!
    @IBOutlet weak var jobSalaryLabel: UILabel!
    
    @IBOutlet weak var viewjobButton: UIButton!
    @IBOutlet weak var viewAllJobsButton: UIButton!
    
//    cell 6
    
    @IBOutlet weak var advertisementImageView: UIImageView!
    
    override func awakeFromNib() {
        if let _ = viewjobButton{
            viewjobButton.setCornerRadiusWithoutBackground(radius: 6.0)
        }
        if let _ = viewAllJobsButton{
            viewAllJobsButton.setCornerRadiusWithoutBackground(radius: 6.0)
        }
        if let _ = galleryCollectionView{

            galleryCollectionView.layoutIfNeeded()
        }
        if  let _ = eventsCollectionView  {
            eventsCollectionView.layoutIfNeeded()
        }
        if  let _ = meetingsCollectionView  {
            meetingsCollectionView.layoutIfNeeded()
        }
        if  let _ = WishesCollectionView  {
            WishesCollectionView.layoutIfNeeded()
        }
        
    }
}

class NewsListPageTableViewCell : UITableViewCell{
       @IBOutlet weak var newsListTitleLabel: UILabel!
       @IBOutlet weak var newsUpdationLabel: UILabel!
       @IBOutlet weak var newsPublishedLabel: UILabel!
       @IBOutlet weak var notificationTitleLabel: UIImageView!
    override func awakeFromNib() {
        
    }
    
}



