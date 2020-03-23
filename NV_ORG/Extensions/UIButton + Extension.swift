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
}
