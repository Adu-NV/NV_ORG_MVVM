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
    
//    cell 5://rightArrowbutton
        @IBOutlet weak var rightArrowbutton: UIButton!
    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var galleryVE: UIVisualEffectView!
    override func awakeFromNib() {
        
        if let _ = meetingDetailsbButton{
            self.meetingDetailsbButton.setCornerRadiusWithoutBackground(radius: 8.0)
        }
        if let _ = meetingNameLabel{
            self.contentView.setViewCornerRadiusWithBorder(radius: 10.0, borderColor: .lightGray, width: 0.5)
        }
        if let _ = wishesChatbButton{
            self.contentView.setViewCornerRadiusWithBorder(radius: 10.0, borderColor: .lightGray, width: 0.5)
            wishesChatbButton.setCornerRadiusWithoutBackground(radius: 8.0)
        }
        if let _ = wishesCallbButton{
            wishesCallbButton.setCornerRadiusWithoutBackground(radius: 8.0)
        }
        if let _ = wishesImageView{
            wishesImageView.setImageViewCornerRadius(radius: 10.0)
        }
        if let _ = eventsImageView{
            self.contentView.setViewCornerRadiusWithBorder(radius: 10.0, borderColor: .black, width: 0.5)
            eventsImageView.setImageViewCornerRadius(radius: 10.0)
        }

    }
}


class LeadershipCollectionViewCell : UICollectionViewCell{
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    @IBOutlet weak var leaderImageView: UIImageView!
    override func awakeFromNib() {
        if let _ = leaderImageView{
            leaderImageView.setImageViewCornerRadiusWithBorder(radius: 30.0, borderwidth: 1.0, color: UIColor.gray)
        }
        
    }
}

class LeadershipCollectionViewReusableCell : UICollectionReusableView{
//    @IBOutlet weak var headerLabel: UILabel!
    var headerLabel = UILabel()
    override func awakeFromNib() {
        
    }
    override init(frame: CGRect) {
         super.init(frame: frame)
//        headerLabel = UILabel()
         self.myCustomInit()
     }

     required init(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)!
        self.myCustomInit()
     }

    func myCustomInit() {
        print("hello there from SupView")
        headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 50)
        headerLabel.center = CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height * 0.5)
        headerLabel.textColor = COMMITEE_MEMBER_TEXT_COLOR
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20.0)//UIFont(name: headerLabel.font.fontName, size: 30)//UIFont(name: "System", size: 30)
        self.addSubview(headerLabel)
     }
}


class galleryCollectionViewCell : UICollectionViewCell{
    @IBOutlet weak var galleryImages: UIImageView!
    override class func awakeFromNib() {
        
    }
}

class GalleryCollectionViewReusableCell : UICollectionReusableView{
 @IBOutlet weak var headerLabel: UILabel!
    
    var headerLabels = UILabel()
    override func awakeFromNib() {
        
    }
    override init(frame: CGRect) {
         super.init(frame: frame)
//        headerLabel = UILabel()
         self.myCustomInit()
     }

     required init(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)!
        self.myCustomInit()
     }

    func myCustomInit() {
        print("hello there from SupView")
        headerLabels = UILabel()
        headerLabels.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 50)
        headerLabels.center = CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height * 0.5)
        headerLabels.textColor = COMMITEE_MEMBER_TEXT_COLOR
        headerLabels.textAlignment = .center
        headerLabels.font = UIFont.boldSystemFont(ofSize: 20.0)//UIFont(name: headerLabel.font.fontName, size: 30)//UIFont(name: "System", size: 30)
        self.addSubview(headerLabels)
     }
}

class celebrationListCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var celebrationPersonImageView: UIImageView!
    @IBOutlet weak var celebrationPersonNameLabel: UILabel!
    @IBOutlet weak var celbrationDateLabel: UILabel!
    override class func awakeFromNib() {
//        if let _ = celebrationPersonImageView{
//            self.contentView.setViewCornerRadiusWithBorder(radius: 10.0, borderColor: .lightGray, width: 0.5)
//        }
//        self.setViewCornerRadiusWithBorder(radius: 10.0, borderColor: .black, width: 0.5)
    }
}
