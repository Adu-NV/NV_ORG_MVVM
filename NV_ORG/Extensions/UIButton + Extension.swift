//
//  UIButton + Extension.swift
//  NV_ORG
//
//  Created by Netventure on 17/03/20.
//  Copyright © 2020 netventure. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    func setCornerRadius(radius : CGFloat ,bg_Color : UIColor){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.backgroundColor = bg_Color
    }
    
    func setCornerRadiusWithoutBackground(radius : CGFloat ){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}






extension UIImageView{
     func setImageViewCornerRadius(radius : CGFloat ){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func setImageViewCornerRadiusWithBorder(radius : CGFloat ,borderwidth : CGFloat , color : UIColor){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderwidth
        self.layer.borderColor = color.cgColor
    }
}





extension UIView{
     func setViewCornerRadius(radius : CGFloat ){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func setViewCornerRadiusWithBorder(radius : CGFloat ,borderColor: UIColor, width : CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderWidth = width
        self.layer.borderColor = borderColor.cgColor
    }
}
