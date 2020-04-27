//
//  extensions + UICollectionViewCels.swift
//  NV_ORG
//
//  Created by Netventure on 24/04/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit
extension UICollectionViewCell{
    func setShadow(radius : CGFloat){
        layer.shadowColor = UIColor.black.cgColor
         layer.shadowOffset = CGSize(width: 0, height: 1.0)
         layer.shadowRadius = 1.0
         layer.shadowOpacity = 0.5
         layer.masksToBounds = false
         layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
         layer.cornerRadius = radius
    }

}
